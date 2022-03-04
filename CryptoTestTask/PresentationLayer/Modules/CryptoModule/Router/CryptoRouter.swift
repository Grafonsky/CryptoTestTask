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
    func showDetailsScreen(id: String)
}

// MARK: - Implementation

final class CryptoRouterImp: CryptoRouterInput {
    weak var view: UIViewController?
    
    func showDetailsScreen(id: String) {
        guard let view = view else { return }
        guard let controller = DetailsAssembly.configDetailsModule(id: id) else { return }
        controller.modalPresentationStyle = .formSheet
        view.present(controller, animated: true)
    }
}
