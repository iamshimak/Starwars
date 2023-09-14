//
//  PlanetInfoTableViewCell.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2023-09-13.
//

import UIKit

class PlanetInfoTableViewCell: UITableViewCell, ReusableView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subtitleLabel.text = nil
        planetImageView.image = nil
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: PlanetViewModel) {
        titleLabel.text = viewModel.planetName
        subtitleLabel.text = viewModel.climate
        
        if let url = URL(string: viewModel.imageUrl) {
            planetImageView.load(from: url)
        }
    }
}
