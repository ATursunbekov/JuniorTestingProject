//
//  BannerCollectionViewCell.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 13/1/24.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "banner"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func configureImage(image: String) {
        self.image.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
