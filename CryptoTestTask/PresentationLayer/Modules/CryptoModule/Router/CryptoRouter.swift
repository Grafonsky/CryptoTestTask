//
//  CryptoRouter.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol CryptoRouterInput {
    func showDetailsScreen(output: ModuleOutput)
}

// MARK: - Implementation

final class CryptoRouterImp: CryptoRouterInput {
    weak var view: UIViewController?
    
    func showDetailsScreen(output: ModuleOutput) {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
