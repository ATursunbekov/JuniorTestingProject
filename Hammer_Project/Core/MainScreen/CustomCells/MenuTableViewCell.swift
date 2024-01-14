//
//  MenuTableViewCell.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 14/1/24.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {
    static let identifier = "MenuTableViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "pizza"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "Ветчина и грибы"
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFUIDisplay-Meium", size: 13)
        label.textColor = UIColor(hex: "#AAAAAD")
        return label
    }()
    
    lazy var cost: UILabel = {
        let label = UILabel()
        label.text = "от 345 р"
        label.font = UIFont(name: "SFUIDisplay-Meium", size: 13)
        label.textColor = UIColor(hex: "#FD3A69")
        label.layer.cornerRadius = 6
        label.layer.borderColor = UIColor(hex: "#FD3A69").cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F3F5F9")
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(titleLable)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cost)
        contentView.addSubview(divider)
        
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(132)
            make.width.equalTo(132)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalTo(image.snp.trailing).offset(32)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(32)
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        cost.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
        
        divider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureData(image: String, title: String, desc: String, cost: String) {
        if let url = URL(string: image) {
            self.image.kf.setImage(with: url)
        }
        self.titleLable.text = title
        self.descriptionLabel.text = desc
        self.cost.text = cost
    }
}
