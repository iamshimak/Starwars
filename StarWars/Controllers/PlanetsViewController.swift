//
//  PlanetsViewController.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

import RxSwift
import RxCocoa

class PlanetsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let viewModel: PlanetsViewModel = PlanetsViewModel()
    private let bag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
        
        viewModel.configure()
        viewModel.fetchData()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: "PlanetInfoTableViewCell", bundle: .main),
            forCellReuseIdentifier: PlanetInfoTableViewCell.defaultReuseIdentifier
        )
    }
    
    // MARK: - Bindings
    
    private func bind() {
        viewModel.planets
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: PlanetInfoTableViewCell.defaultReuseIdentifier,
                cellType: PlanetInfoTableViewCell.self
            )) { index, model, cell in
                cell.configure(with: model)
            }.disposed(by: bag)
        
        viewModel.onError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showMessage(title: "Error", message: error.localizedDescription)
            }).disposed(by: bag)
        
        tableView.rx.modelSelected(PlanetViewModel.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] planetViewModel in
                self?.viewModel.selectedPlanet = planetViewModel
                self?.performSegue(withIdentifier: "planetDetail", sender: self)
            }).disposed(by: bag)
        
        tableView.rx.willDisplayCell
            .filter { self.viewModel.hasReachFinalPlanet(row: $0.indexPath.row) }
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.fetchData()
            }).disposed(by: bag)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? PlanetDetailViewController,
              let selectedPlanet = viewModel.selectedPlanet else {
            return
        }
        
        controller.viewModel = selectedPlanet
    }
}

