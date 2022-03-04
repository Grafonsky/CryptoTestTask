//
//  DetailsInteractor.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol DetailsInteractorInput {
    var output: DetailsInteractorOutput? { get set }
    func loadDetails(id: String)
    func onFavorite(name: String)
}

protocol DetailsInteractorOutput: AnyObject {
    func updateModel(model: DetailedModel)
    func updateFavorites(favorites: [String])
}

// MARK: - Implementation

final class DetailsInteractorImp: DetailsInteractorInput {
    weak var output: DetailsInteractorOutput?
    
    var cryptoService: CryptoServiceImp!
    var storageService: StorageServiceImp!
    
    
    // MARK: - Protocol funcs
    
    func loadDetails(id: String) {
        output?.updateFavorites(favorites: loadFavorites())
        cryptoService.getCryptoDetails(id: id) { [weak self] model in
            DispatchQueue.main.sync {
                self?.output?.updateModel(model: model)
            }
        }
    }
    
    func onFavorite(name: String) {
        var favorites = loadFavorites()
        if !favorites.contains(name) {
            favorites.append(name)
        } else {
            favorites.enumerated().forEach { index, value in
                if value == name {
                    favorites.remove(at: index)
                }
            }
        }
        saveFavorites(favorites: favorites)
        output?.updateFavorites(favorites: loadFavorites())
    }
    
    // MARK: - Private funcs
    
    private func saveFavorites(favorites: [String]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(favorites)
        storageService.setData(key: StorageEnum.favorites, value: data)
    }
    
    private func loadFavorites() -> [String] {
        let decoder = JSONDecoder()
        let data = storageService.getData(key: StorageEnum.favorites)
        guard let favorites = try? decoder.decode([String].self, from: data) else { return [] }
        return favorites
    }
    
}
