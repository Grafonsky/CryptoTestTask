//
//  CoinCell.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import UIKit
import SnapKit

class CoinCell: UITableViewCell {
    
    lazy var logo = UIImageView()
    lazy var name = UILabel()
    lazy var totalCapitalization = UILabel()
    lazy var currentPrice = UILabel()
    lazy var favoritePic = UIImageView()
    lazy var favoriteButton = UIButton()

    var onFavorite: (() -> ())?
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Config
    
    private func config() {
        configLogo()
        configName()
        configTotalCapitalization()
        configCurrentPrice()
        configFavoritePic()
        configFavoriteButton()
    }
    
    private func configLogo() {
        self.addSubview(logo)
        logo.backgroundColor = .clear
        logo.snp.makeConstraints { (make) -> Void in
            make.leading.top.equalTo(15)
            make.height.width.equalTo(40)
        }
    }
    
    private func configName() {
        self.addSubview(name)
        name.text = "Coin name"
        name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.leading.equalTo(70)
        }
    }
    
    private func configTotalCapitalization() {
        self.addSubview(totalCapitalization)
        totalCapitalization.text = "Total Capitalization"
        totalCapitalization.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(40)
            make.leading.equalTo(70)
        }
    }
    
    private func configCurrentPrice() {
        self.addSubview(currentPrice)
        currentPrice.text = "$1337.0"
        currentPrice.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(27)
            make.trailing.equalTo(-80)
        }
    }
    
    private func configFavoritePic() {
        self.addSubview(favoritePic)
        favoritePic.image = UIImage(systemName: "star")
        favoritePic.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(23)
            make.trailing.equalTo(-23)
            make.height.width.equalTo(25)
        }
    }
    
    private func configFavoriteButton() {
        self.addSubview(favoriteButton)
        favoriteButton.backgroundColor = .clear
        favoriteButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(15)
            make.trailing.equalTo(-15)
            make.height.width.equalTo(40)
        }
        favoriteButton.addTarget(self, action: #selector(actionFavorite), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func actionFavorite() {
        onFavorite?()
    }


}
