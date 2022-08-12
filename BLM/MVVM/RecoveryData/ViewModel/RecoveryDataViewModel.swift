//
//  RecoveryDataViewModel.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 12/08/22.
//

import Foundation
import UIKit

final class RecoveryDataViewModel {

    public var error: Observable<Error?> = Observable(nil)
    public var recoveryDataResponse: Observable <Bool?> = Observable(nil)

    public var response: BLMModel?
    private var recoveryData: RecoveryData?
    init(recoveryData: RecoveryData) {
        self.recoveryData = recoveryData
    }

    public func getRecoveryData() {
        recoveryData?.requestData(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.response = result
                self?.recoveryDataResponse.value = true
            case .failure(let error):
                self?.error.value = error
            }
        })
    }

    var numberOfRows: Int {
        return response?.data?.count ?? 0
    }

    func getDataForRow(index: Int) -> Datum? {
        return response?.data?[index]
    }
}
