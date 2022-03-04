//
//  CryptoAssembly.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import UIKit

final class CryptoAssembly {
    static func configCryptoModule() -> UIViewController? {
        let storyboard = UIStoryboard(name: "CryptoView", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CryptoView") as? CryptoViewController else { return UIViewController() }
        
        let presenter = CryptoPresenterImp()
        let interactor = CryptoInteractorImp()
        let router = CryptoRouterImp()
        
        let cryptoService = CryptoServiceImp()
        let storageService = StorageServiceImp()
        
        presenter.interactor = interactor
        presenter.view = controller
        presenter.router = router
        
        interactor.output = presenter
        interactor.storageService = storageService
        interactor.cryptoService = cryptoService
        
        controller.presenter = presenter
        
        router.view = controller
        
        return controller
    }
}
