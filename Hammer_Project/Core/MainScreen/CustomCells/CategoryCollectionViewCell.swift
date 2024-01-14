//
//  CategoryCollectionViewCell.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 13/1/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    lazy var border: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hex: "#FD3A69", alpha: 0.4).cgColor
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Medium", size: 13)
        label.textColor = UIColor(hex: "#FD3A69", alpha: 0.4)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(border)
        border.addSubview(name)
        
        border.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configureData(name: String) {
        self.name.text = name
    }
    
    func selected() {
        border.backgroundColor = UIColor(hex: "#FD3A69", alpha: 0.4)
        border.layer.borderColor = UIColor(hex: "#FD3A69", alpha: 0.4).cgColor
        name.textColor =  UIColor(hex: "#FD3A69")
        name.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
    }
    
    func deselect() {
        border.backgroundColor = .clear
        name.textColor =  UIColor(hex: "#FD3A69", alpha: 0.4)
        name.font = UIFont(name: "SFUIDisplay-Medium", size: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
