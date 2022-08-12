//
//  HomeViewController.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 11/08/22.
//

import UIKit

class HomeViewController: UITableViewController {

    public var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case CellTypesEnum.QR.id:
            coordinator?.openQRView()
        case CellTypesEnum.RecoverData.id:
            coordinator?.openRecoveryData()
        default:
            break
        }
    }
}

extension HomeViewController: Storyboarded {

    static var storyboardName: String {
        return "Main"
    }
}
