//
//  CryptoViewController.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import UIKit
import SnapKit

class CryptoViewController: UIViewController {
    var presenter: CryptoPresenterInput!
    
    lazy var tabBar = UIView()
    lazy var tableView = UITableView()
    lazy var sortingButton = UIButton()
    lazy var sortingPic = UIImageView()
    lazy var refreshButton = UIButton()
    lazy var refreshPic = UIImageView()
    
    var entity: [CryptoEntity] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        presenter.viewIsReady()
    }
    
    // MARK: - Config
    
    private func config() {
        configTopBar()
        configTableView()
    }
    
    private func configTopBar() {
        tabBar.backgroundColor = .clear
        self.view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(view.frame.height / 8)
        }
        configSorting()
        configRefresh()
    }
    
    private func configRefresh() {
        tabBar.addSubview(refreshPic)
        refreshPic.image = UIImage(systemName: "arrow.clockwise")
        refreshPic.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.trailing.equalTo(-25)
            make.top.equalTo(65)
        }
        
        tabBar.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(40)
            make.trailing.equalTo(-20)
            make.top.equalTo(60)
        }
        refreshButton.addTarget(self, action: #selector(actionRefresh), for: .touchUpInside)
    }
    
    private func configSorting() {
        tabBar.addSubview(sortingPic)
        sortingPic.image = UIImage(systemName: "arrow.down")
        sortingPic.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.leading.equalTo(25)
            make.top.equalTo(65)
        }
        
        tabBar.addSubview(sortingButton)
        sortingButton.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(40)
            make.leading.equalTo(20)
            make.top.equalTo(60)
        }
        sortingButton.addTarget(self, action: #selector(actionSorting), for: .touchUpInside)
    }
    
    private func configTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(tabBar.snp_bottomMargin)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "CoinCell")
        tableView.backgroundColor = .clear
        
    }
    
    // MARK: - Actions
    
    @objc private func actionRefresh() {
        presenter.refresh()
        sortingPic.image = UIImage(systemName: "arrow.down")
    }
    
    @objc private func actionSorting() {
        presenter.changeSorting()
        if sortingPic.image == UIImage(systemName: "arrow.up") {
            sortingPic.image = UIImage(systemName: "arrow.down")
        } else {
            sortingPic.image = UIImage(systemName: "arrow.up")
        }
    }
    
}

// MARK: - Extensions
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let crypto = entity[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as? CoinCell {
            cell.name.text = crypto.name
            cell.logo.image = presenter.coinsLogo[crypto.name]
            if presenter.favorites.contains(crypto.name) {
                cell.favoritePic.image = UIImage(systemName: "star.fill")
            } else {
                cell.favoritePic.image = UIImage(systemName: "star")
            }
            cell.currentPrice.text = "$\(NSString(format:"%.2f", crypto.current_price))"
            cell.totalCapitalization.text = "$\(NSString(format:"%.2f", crypto.market_cap))"
            cell.onFavorite = {[weak self] in
                self?.presenter.addToFavorites(name: crypto.name)
            }
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crypto = entity[indexPath.row]
        presenter.showDetails(id: crypto.id)
    }
}

extension CryptoViewController: CryptoPresenterOutput {
    func setState() {
        entity = presenter.entity
        tableView.reloadData()
    }
    
    func updateFavorites() {
        tableView.reloadData()
    }
}
