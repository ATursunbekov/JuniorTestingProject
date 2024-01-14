//
//  ViewController.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 13/1/24.
import UIKit
import SnapKit

class ViewController: UIViewController {
    var presenter: MainPresenter?
    
    init(presenter: MainPresenter? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = MainPresenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "arrowDown"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 16
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F3F5F9")
        setupConstraints()
        setupDelegates()
        presenter?.fetchData(url: .pizza)
        presenter?.delegate = self
    }
    
    func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func setupConstraints() {
        view.addSubview(cityName)
        view.addSubview(image)
        view.addSubview(collectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(menuTableView)
        
        cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(15)
        }
        
        image.snp.makeConstraints { make in
            make.centerY.equalTo(cityName.snp.centerY)
            make.leading.equalTo(cityName.snp.trailing).offset(8)
            make.width.equalTo(14)
            make.height.equalTo(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {return 0}
        if collectionView == self.collectionView {
            return presenter.images.count
        } else if collectionView == categoryCollectionView {
            return presenter.categories.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {return UICollectionViewCell()}
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            cell.configureImage(image: presenter.images[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.configureData(name: presenter.categories[indexPath.row])
            if indexPath.row == 0 {
                cell.selected()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else {return}
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.cellForItem(at: presenter.selectedCategory) as? CategoryCollectionViewCell
            cell?.deselect()
            let chosenCell = categoryCollectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
            chosenCell?.selected()
            presenter.selectedCategory = indexPath
            if indexPath.row == 0 {
                presenter.fetchData(url: .pizza)
            } else if indexPath.row == 1 {
                presenter.fetchData(url: .combo)
            } else if indexPath.row == 2 {
                presenter.fetchData(url: .desert)
            } else if indexPath.row == 3 {
                presenter.fetchData(url: .drinks)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: 300, height: 112)
        } else {
            return CGSize(width: 88, height: 32)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.pizza.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        let temp = presenter?.pizza[indexPath.row]
        if let temp = temp {
            cell.configureData(image: temp.image_url, title: temp.title, desc: temp.description, cost: temp.cost)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == menuTableView {
            UIView.animate(withDuration: 0.5) {
                if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
                    self.collectionView.isHidden = true
                    self.collectionView.snp.updateConstraints { make in
                        make.top.equalTo(self.cityName.snp.bottom)
                        make.height.equalTo(0)
                    }
                } else {
                    // Scrolling up, show the view
                    self.collectionView.isHidden = false
                    self.collectionView.snp.updateConstraints { make in
                        make.top.equalTo(self.cityName.snp.bottom).offset(24)
                        make.height.equalTo(112)
                    }
                }
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension ViewController: PresenterDelegate {
    func responceAction() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                self.menuTableView.reloadData()
            }
        }
    }
}
