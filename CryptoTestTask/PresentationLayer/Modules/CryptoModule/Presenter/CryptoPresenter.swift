//
//  CryptoPresenter.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol CryptoPresenterInput {
    var view: CryptoPresenterOutput? { get set }
    var entity: [CryptoEntity] { get set }
    
    func viewIsReady()
    func refresh()
    func changeSorting()
    func addToFavorites(name: String)
    func showDetails(name: String)
}

protocol CryptoPresenterOutput: AnyObject {
    func setState()
}

// MARK: - Protocols funcs

final class CryptoPresenterImp: CryptoPresenterInput {
    
    weak var view: CryptoPresenterOutput?
    
    var interactor: CryptoInteractorInput!
    var router: CryptoRouterInput!
    
    var entity: [CryptoEntity] = []
    
    // MARK: - Protocol funcs
    
    func viewIsReady() {
        loadCrypto()
    }
    
    func refresh() {
        interactor.loadCryptoList()
    }
    
    func changeSorting() {
        entity.reverse()
        view?.setState()
    }
    
    func addToFavorites(name: String) {
        interactor.addToFavorites(name: name)
    }
    
    func showDetails(name: String) {
        //        let
        //        router.showDetailsScreen(coin: CryptoEntity)
    }
    
    // MARK: - Private funcs
    
    private func loadCrypto() {
        interactor.loadCryptoList()
    }
}

// MARK: - Extensions

extension CryptoPresenterImp: CryptoInteractorOutput {
    func updateData(entity: [CryptoEntity]) {
        self.entity = entity
        view?.setState()
    }
}

