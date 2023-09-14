//
//  PlanetDetailViewController.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

import RxCocoa
import RxSwift

class PlanetDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var messageStackView: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orbitalNameLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: PlanetViewModel!
    
    private let bag: DisposeBag = DisposeBag()
    
    // MARK: - Initialisers
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onOrientationChanges(App.orientation())
    }
    
    // MARK: - Configurations
    
    private func configure() {
        nameLabel.text = viewModel.planetName
        orbitalNameLabel.text = viewModel.orbitalPeriod
        gravityLabel.text = viewModel.gravity
        
        if let url = URL(string: viewModel.imageUrl) {
            imageView.load(from: url)
        }
    }
    
    // MARK: - Binding
    
    private func binding() {
        NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
            .observe(on: MainScheduler.instance)
            .filter { _ in App.isValidOrientation }
            .map { _ in App.orientation() }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] orientation in
                self?.onOrientationChanges(orientation)
            })
            .disposed(by: bag)
    }
    
    // MARK: -
    
    private func onOrientationChanges(_ orientation: Orientation) {
        switch orientation {
        case .portrait:
            self.mainStackView.axis = .vertical
        case .landscape:
            self.mainStackView.axis = .horizontal
        }
    }
}

