//
//  DessertTableViewCell.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import UIKit
import SDWebImage

class DessertTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(TableCellConstant.fatalError)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(dessertImageView)
        contentView.addSubview(nameLabel)
        
        dessertImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dessertImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dessertImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dessertImageView.heightAnchor.constraint(equalToConstant: 80),
            dessertImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 12),
            nameLabel.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
     func configureCell(with meal: Desserts) {
        nameLabel.text = meal.strMeal
        //Using SDWebImage to load image from URL.
        dessertImageView.sd_setImage(with: URL(string: meal.strMealThumb),
                                     placeholderImage: UIImage(named: TableCellConstant.placeHolderImage),
                                     options: .continueInBackground)
    }
}
