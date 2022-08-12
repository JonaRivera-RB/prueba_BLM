//
//  Environment.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 12/08/22.
//

import Foundation
import APIJR

class Development: Endpoint {
    var environment: String = ""
    var scheme: String = "https"
    var baseURL: String = "gorest.co.in"
    var headers: [String : String] = [ "Content-Type": "application/json"]
}
