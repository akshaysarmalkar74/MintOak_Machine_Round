//
//  FilterDataResponse.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import Foundation

// MARK: - FilterDataResponse
struct FilterDataResponse: Codable {
    let status, message, errorCode: String?
    let filterData: [FilterData]?
}

// MARK: - FilterData
struct FilterData: Codable {
    let cif, companyName: String?
    let accountList, brandList, locationList: [String]?
    let hierarchy: [Hierarchy]?

    enum CodingKeys: String, CodingKey {
        case cif = "Cif"
        case companyName, accountList, brandList, locationList, hierarchy
    }
}

// MARK: - Hierarchy
struct Hierarchy: Codable {
    let accountNumber: String?
    let brandNameList: [BrandNameList]?
}

// MARK: - BrandNameList
struct BrandNameList: Codable {
    let brandName: String?
    let locationNameList: [LocationNameList]?
}

// MARK: - LocationNameList
struct LocationNameList: Codable {
    let locationName: String?
    let merchantNumber: [MerchantNumber]?
}

// MARK: - MerchantNumber
struct MerchantNumber: Codable {
    let mid: String?
    let outletNumber: [String]?
}
