//
//  RecoveryDataUseCase.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 12/08/22.
//

import Foundation
import APIJR

protocol RecoveryData {
    func requestData(completion: @escaping (Result<BLMModel?, Error>) -> ())
}

struct RecoveryDataUseCase: RecoveryData {

    func requestData(completion: @escaping (Result<BLMModel?, Error>) -> ()) {
        let network = NetworkEngine(path: "/public/v1/users", parameters: nil, method: .get, endpoint: Development())
        network.request(completion: completion)
    }
}

