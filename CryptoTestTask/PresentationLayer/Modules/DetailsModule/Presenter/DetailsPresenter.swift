//
//  DetailsPresenter.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol DetailsPresenterInput {
    var coinName: String { get set }
    var view: DetailsPresenterOutput? { get set }
    func viewIsReady(id: String)
    func loadDetails(id: String)
    func onFavorite(name: String)
}

protocol DetailsPresenterOutput: AnyObject {
    func setState(model: DetailedModel)
    func updateFavorites()

}

// MARK: - Implementation

final class DetailsPresenterImp: DetailsPresenterInput {
    weak var view: DetailsPresenterOutput?
    var interactor: DetailsInteractorInput!
    var coinName: String = ""
    var favorites: [String] = []
    
    // MARK: - Protocol funcs

    func viewIsReady(id: String) {
        loadDetails(id: id)
    }
    
    func loadDetails(id: String) {
        interactor.loadDetails(id: id)
    }
    
    func onFavorite(name: String) {
        interactor.onFavorite(name: name)
    }
   
}

// MARK: - Extensions

extension DetailsPresenterImp: DetailsInteractorOutput {
    func updateFavorites(favorites: [String]) {
        self.favorites = favorites
        view?.updateFavorites()
    }
    
    func updateModel(model: DetailedModel) {
        view?.setState(model: model)
    }
    
}
