//
//  DetailsAssembly.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import UIKit

final class DetailsAssembly {
    static func configDetailsModule(id: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: "DetailsView", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController else { return UIViewController() }
        
        let presenter = DetailsPresenterImp()
        let interactor = DetailsInteractorImp()
        
        let cryptoService = CryptoServiceImp()
        let storageService = StorageServiceImp()
        
        presenter.interactor = interactor
        presenter.view = controller
        
        interactor.output = presenter
        interactor.cryptoService = cryptoService
        interactor.storageService = storageService
        
        controller.presenter = presenter
        controller.currentCoin = id
        
        return controller
    }
}
