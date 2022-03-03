//
//  Module.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

// MARK: - Protocol

protocol ModuleOutput: AnyObject {
    func didUpdateModel(model: ModuleOutput)
}
