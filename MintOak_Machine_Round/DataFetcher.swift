//
//  DataFetcher.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import Foundation

class DataFetcher {
    let filePath: URL

    init(fileName: String) {
        self.filePath = Bundle.main.url(forResource: fileName, withExtension: "json")!
    }

    func readJSON<T: Decodable>(type: T.Type) -> T? {
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

extension DataFetcher {
    static func fetchAllLocations(filterData: FilterData) -> [String] {
        return filterData.locationList ?? []
    }
    
    static func fetchAllBrands(filterData: FilterData) -> [String] {
        return filterData.brandList ?? []
    }
    
    static func fetchAllAccounts(filterData: FilterData) -> [String] {
        return filterData.accountList ?? []
    }
    
    static func fetchMIDNumbers(filterData: [FilterData], selectedFilterData: SelectedFilterData) -> [String?] {
        var midNumbers = [String?]()
        
        // Fetch FilterData Based on Company Name
        if let selectedCompanyHeirarchy = filterData.first(where: { $0.companyName == selectedFilterData.companyName })?.hierarchy {
            // Filter Data based on Brand, AccountID, and Location
            for heirarchy in selectedCompanyHeirarchy {
                // Check if Account Number Matches
                if selectedFilterData.accounts.contains(heirarchy.accountNumber ?? "") {
                    // Check if Brand Matches
                    let brandsList = heirarchy.brandNameList ?? []
                    for brand in brandsList {
                        if selectedFilterData.brands.contains(brand.brandName ?? "") {
                            // Check if Location Matches
                            let locationList = brand.locationNameList ?? []
                            for location in locationList {
                                if selectedFilterData.locations.contains(location.locationName ?? "") {
                                    // Add MID Number
                                    midNumbers.append(location.merchantNumber?.first?.mid)
                                }
                            }
                        }
                    }
                }
            }
        }
        return midNumbers
    }
}

struct SelectedFilterData {
    let companyName: String
    let accounts: [String]
    let brands: [String]
    let locations: [String]
}
