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
    func loadCryptoDetails(id: String)
    func addToFavorites(name: String)
}

protocol CryptoInteractorOutput: AnyObject {
    func updateData(entity: [CryptoEntity])
}

// MARK: - Implementation

final class CryptoInteractorImp: CryptoInteractorInput {
    
    weak var output: CryptoInteractorOutput?
    
    var cryptoService: CryptoServiceImp!
    var storageService: StorageServiceImp!
    
    // MARK: - Protocol funcs
    
    func loadCryptoList() {
        setOldModel()
        DispatchQueue.global(qos: .background).async {
            self.cryptoService.getCryptoList{ [weak self] coins in
                DispatchQueue.main.async {
                    self?.output?.updateData(entity: coins)
                    self?.saveEntity(entity: coins)
                }
            }
        }
        
    }
    
    func loadCryptoDetails(id: String) {

    }
    
    func addToFavorites(name: String) {
        
    }
    
    // MARK: - Private funcs
    
    private func setOldModel() {
        guard let oldModel = loadEntity() else { return }
        self.output?.updateData(entity: oldModel)
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
}
