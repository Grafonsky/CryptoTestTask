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
    var favorites: [String] { get set }
    
    func viewIsReady()
    func refresh()
    func changeSorting()
    func addToFavorites(name: String)
    func showDetails(id: String)
}

protocol CryptoPresenterOutput: AnyObject {
    func setState()
    func updateFavorites()
}

// MARK: - Protocols funcs

final class CryptoPresenterImp: CryptoPresenterInput {
    
    weak var view: CryptoPresenterOutput?
    
    var interactor: CryptoInteractorInput!
    var router: CryptoRouterInput!
    
    var entity: [CryptoEntity] = []
    var favorites: [String] = []
    
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
    
    func showDetails(id: String) {
        router.showDetailsScreen(id: id)
    }
    
    // MARK: - Private funcs
    
    private func loadCrypto() {
        interactor.loadCryptoList()
    }
}

// MARK: - Extensions

extension CryptoPresenterImp: CryptoInteractorOutput {
    func updateEntity(entity: [CryptoEntity]) {
        self.entity = entity
        view?.setState()
    }
    
    func updateFavorites(favorites: [String]) {
        self.favorites = favorites
        view?.updateFavorites()
    }
    
    
}

