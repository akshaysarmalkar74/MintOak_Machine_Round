//
//  CommonEnumAndStruct.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 14/04/24.
//

import Foundation

struct SelectedFilterData {
    let companyName: String
    let accounts: [String?]
    let brands: [String?]
    let locations: [String?]
}

enum FilterTypes {
    case account(num: Int)
    case brand(num: Int)
    case location(num: Int)
    
    var displayText: String {
        switch self {
            case .account:
                return "Select Account Number"
            case .brand:
                return "Select Brand"
            case .location:
                return "Select Location"
        }
    }
    
    func getValue() -> Int {
        switch self {
            case .account(num: let num):
                return num
            case .brand(num: let num):
                return num
            case .location(num: let num):
                return num
        }
    }
    
    func getSelectedValues(selectedFilterData: SelectedFilterData?) -> [String?] {
        switch self {
            case .account:
                return selectedFilterData?.accounts ?? []
            case .brand:
                return selectedFilterData?.brands ?? []
            case .location:
                return selectedFilterData?.locations ?? []
        }
    }
    
    func getAllSelectedValues(selectedFilterData: FilterData?) -> [String] {
        switch self {
            case .account:
                return selectedFilterData?.accountList ?? []
            case .brand:
                return selectedFilterData?.brandList ?? []
            case .location:
                return selectedFilterData?.locationList ?? []
        }
    }
}

