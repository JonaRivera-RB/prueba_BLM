//
//  BLMModel.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 12/08/22.
//

import Foundation

// MARK: - BLMModel
struct BLMModel: Codable {
    let meta: Meta?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let gender: String?
    let status: String?
}

// MARK: - Meta
struct Meta: Codable {
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, pages, page, limit: Int?
}
