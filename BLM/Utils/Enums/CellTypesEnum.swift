//
//  CellTypesEnum.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 11/08/22.
//

import Foundation

enum CellTypesEnum {
    case QR
    case RecoverData

    var id: Int {
        switch self {
        case .QR:
            return 0
        case .RecoverData:
            return 1
        }
    }
}
