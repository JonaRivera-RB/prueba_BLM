//
//  Coordinator.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 11/08/22.
//

import Foundation
import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        navigationController.delegate = self
        guard let vc = HomeViewController.instantiate() as? HomeViewController else { return }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    public func openQRView() {
        guard let vc = QRViewController.instantiate() as? QRViewController else { return }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    public func openRecoveryData() {
        guard let vc = RecoveryDataViewController.instantiate() as? RecoveryDataViewController else { return }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
