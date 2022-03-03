//
//  StorageService.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol StorageService {
    func setData(key: String, value: Data?)
    func getData(key: String) -> Data
}

// MARK: - Implementation

final class StorageServiceImp: StorageService {
    
    let defaults = UserDefaults.standard
    
    // MARK: - Protocols funcs
    
    func setData(key: String, value: Data?) {
        defaults.set(value, forKey: key)
    }
    
    func getData(key: String) -> Data {
        defaults.data(forKey: key) ?? Data()
    }
}
