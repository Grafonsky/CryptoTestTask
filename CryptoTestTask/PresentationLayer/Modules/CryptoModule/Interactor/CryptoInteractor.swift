//
//  CryptoInteractor.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol CryptoInteractorInput {
    var output: CryptoInteractorOutput? { get set }
    
    func loadCryptoList()
    func addToFavorites(name: String)
}

protocol CryptoInteractorOutput: AnyObject {
    func updateEntity(entity: [CryptoEntity])
    func updateFavorites(favorites: [String])
}

// MARK: - Implementation

final class CryptoInteractorImp: CryptoInteractorInput {
    
    weak var output: CryptoInteractorOutput?
    
    var cryptoService: CryptoServiceImp!
    var storageService: StorageServiceImp!
    
    // MARK: - Protocol funcs
    
    func loadCryptoList() {
        output?.updateFavorites(favorites: loadFavorites())
        setOldModel()
        self.cryptoService.getCryptoList{ [weak self] coins in
            DispatchQueue.main.async {
                self?.output?.updateEntity(entity: coins)
            }
            self?.saveEntity(entity: coins)

        }
        
    }
    
    func addToFavorites(name: String) {
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
    
    private func setOldModel() {
        guard let oldModel = loadEntity() else { return }
        self.output?.updateEntity(entity: oldModel)
    }
    
    private func saveEntity(entity: [CryptoEntity]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(entity)
        storageService.setData(key: StorageEnum.cryptoEntity, value: data)
    }
    
    private func loadEntity() -> [CryptoEntity]? {
        let decoder = JSONDecoder()
        let data = storageService.getData(key: StorageEnum.cryptoEntity)
        let entity = try? decoder.decode([CryptoEntity].self, from: data)
        return entity
    }
    
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
