//
//  DetailsViewController.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var presenter: DetailsPresenterImp!
    
    lazy var refreshPic = UIImageView()
    lazy var refreshButton = UIButton()
    lazy var favoritePic = UIImageView()
    lazy var favoriteButton = UIButton()
    lazy var name = UILabel()
    lazy var symbol = UILabel()
    lazy var image = UIImageView()
    lazy var currentPrice = UILabel()
    lazy var marketCapitalization = UILabel()
    lazy var highPerDay = UILabel()
    lazy var lowPerDay = UILabel()
    lazy var atlDate = UILabel()
    lazy var isFavorite = UIImageView()

    var currentCoin: String = ""
    var coinName: String = ""
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewIsReady(id: currentCoin)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()

        
    }
    
    // MARK: - Config
    
    private func config() {
        configRefresh()
        configFavorite()
        configName()
        configSymbol()
        configImage()
        configCurrentPrice()
        configMarketCap()
        configHighPerDay()
        configLowPerDay()
        configAtlDate()
        
    }
    
    private func configRefresh() {
        view.addSubview(refreshPic)
        refreshPic.image = UIImage(systemName: "arrow.clockwise")
        refreshPic.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.trailing.equalTo(-25)
            make.top.equalTo(20)
        }
        
        view.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(40)
            make.trailing.equalTo(-20)
            make.top.equalTo(15)
        }
        refreshButton.addTarget(self, action: #selector(actionRefresh), for: .touchUpInside)
    }
    
    private func configFavorite() {
        view.addSubview(favoritePic)
        favoritePic.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(30)
            make.leading.equalTo(25)
            make.top.equalTo(20)
        }
        
        view.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(40)
            make.leading.equalTo(20)
            make.top.equalTo(15)
        }
        favoriteButton.addTarget(self, action: #selector(actionFavorite), for: .touchUpInside)
    }
    
    private func configName() {
        view.addSubview(name)
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .left
        name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(85)
            make.leading.equalTo(105)
        }
    }
    
    private func configSymbol() {
        view.addSubview(symbol)
        symbol.font = UIFont.systemFont(ofSize: 15)
        symbol.textAlignment = .left
        symbol.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(name.snp_bottomMargin).offset(5)
            make.leading.equalTo(105)
        }
    }
    
    private func configImage() {
        view.addSubview(image)
        image.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(65)
            make.leading.equalTo(25)
            make.top.equalTo(75)
        }
    }
    
    private func configCurrentPrice() {
        view.addSubview(currentPrice)
        currentPrice.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .right
        currentPrice.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(85)
            make.trailing.equalTo(-25)
        }
    }
    
    private func configMarketCap() {
        view.addSubview(marketCapitalization)
        marketCapitalization.font = UIFont.systemFont(ofSize: 20)
        marketCapitalization.textAlignment = .left
        marketCapitalization.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(image.snp_bottomMargin).offset(35)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
        }
    }
    
    private func configHighPerDay() {
        view.addSubview(highPerDay)
        highPerDay.font = UIFont.systemFont(ofSize: 20)
        highPerDay.textAlignment = .left
        highPerDay.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(marketCapitalization.snp_bottomMargin).offset(35)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
        }
    }
    
    private func configLowPerDay() {
        view.addSubview(lowPerDay)
        lowPerDay.font = UIFont.systemFont(ofSize: 20)
        lowPerDay.textAlignment = .left
        lowPerDay.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(highPerDay.snp_bottomMargin).offset(35)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
        }
    }
    
    private func configAtlDate() {
        view.addSubview(atlDate)
        atlDate.font = UIFont.systemFont(ofSize: 20)
        atlDate.textAlignment = .left
        atlDate.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lowPerDay.snp_bottomMargin).offset(35)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
        }
    }
    
    // MARK: - Private funcs
    
    private func checkFavorite() -> Bool {
        if presenter.favorites.contains(coinName) {
            return true
        } else {
            return false
        }
    }

    
    // MARK: - Actions
    
    @objc private func actionRefresh() {
        presenter.loadDetails(id: currentCoin)
    }
    
    @objc private func actionFavorite() {
        presenter.onFavorite(name: coinName)
    }
    
}

// MARK: - Extensions

extension DetailsViewController: DetailsPresenterOutput {
    func updateFavorites() {
        if checkFavorite() {
            favoritePic.image = UIImage(systemName: "star.fill")
        } else {
            favoritePic.image = UIImage(systemName: "star")
        }
    }
    
    func setState(model: DetailedModel) {
        guard let unwrapName = model.name else { return }
        coinName = unwrapName
        name.text = unwrapName
        symbol.text = model.symbol
        guard let link = model.image?.large else { return }
        guard let url: URL = URL(string: link) else { return }
        if let imageData: NSData = NSData(contentsOf: url) {
            image.image = UIImage(data: imageData as Data)
        }
        guard let price = model.market_data?.current_price.usd else { return }
        currentPrice.text = "$\(NSString(format:"%.2f", price))"
        guard let totalCap = model.market_data?.market_cap?.usd else { return }
        marketCapitalization.text = "Total capitalization: $\(NSString(format:"%.2f", totalCap))"
        guard let high = model.market_data?.high_24h?.usd else { return }
        highPerDay.text = "Highset in 24h: $\(NSString(format:"%.2f", high))"
        guard let low = model.market_data?.low_24h?.usd else { return }
        lowPerDay.text = "Lowest in 24h: $\(NSString(format:"%.2f", low))"
        guard let firstBlock = model.genesis_date else { return }
        atlDate.text = "Genesis date: \(firstBlock)"
        if checkFavorite() {
            favoritePic.image = UIImage(systemName: "star.fill")
        } else {
            favoritePic.image = UIImage(systemName: "star")
        }
  
    }
}
