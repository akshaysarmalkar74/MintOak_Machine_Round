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
    static func fetchAllLocations(filterData: FilterData?) -> [String] {
        return filterData?.locationList ?? []
    }
    
    static func fetchAllBrands(filterData: FilterData?) -> [String] {
        return filterData?.brandList ?? []
    }
    
    static func fetchAllAccounts(filterData: FilterData?) -> [String] {
        return filterData?.accountList ?? []
    }
    
    static func fetchMIDNumbers(filterData: [FilterData], selectedFilterData: SelectedFilterData) -> [String?] {
        var midNumbers = [String?]()
        
        // Fetch FilterData Based on Company Name
        if let selectedCompanyHeirarchy = filterData.first(where: { $0.companyName == selectedFilterData.companyName })?.hierarchy {
            // Filter Data based on Brand, AccountID, and Location
            for heirarchy in selectedCompanyHeirarchy {
                // Check if Brand Matches
                let brandsList = heirarchy.brandNameList ?? []
                for brand in brandsList {
                    let locationList = brand.locationNameList ?? []
                    for location in locationList {
                        if (selectedFilterData.locations.contains(location.locationName ?? "") &&
                            selectedFilterData.accounts.contains(heirarchy.accountNumber ?? "") &&
                            selectedFilterData.brands.contains(brand.brandName ?? "")) {
                            // Add MID Number
                            midNumbers.append(location.merchantNumber?.first?.mid)
                        }
                    }
                }
            }
        }
        return midNumbers
    }
    
    static func fetchBasedOn(accountNumber: [String?], filterData: [FilterData], selectedFilterData: SelectedFilterData?) -> SelectedFilterData {
        var brands = [String?]()
        var locations = [String?]()
        
        // Fetch FilterData Based on Company Name
        if let selectedCompanyHeirarchy = filterData.first(where: { $0.companyName == selectedFilterData?.companyName })?.hierarchy {
            // Filter Data based on Brand, AccountID, and Location
            for heirarchy in selectedCompanyHeirarchy {
                // Check if Brand Matches
                let brandsList = heirarchy.brandNameList ?? []
                for brand in brandsList {
                    let locationList = brand.locationNameList ?? []
                    for location in locationList {
                        if (accountNumber.contains(heirarchy.accountNumber ?? "")) {
                            if !brands.contains(brand.brandName) {
                                brands.append(brand.brandName)
                            }
                            
                            if !locations.contains(location.locationName) {
                                locations.append(location.locationName)
                            }
                        }
                    }
                }
            }
        }
        return SelectedFilterData(companyName: selectedFilterData?.companyName ?? "", accounts: accountNumber, brands: brands, locations: locations)
    }
    
    static func fetchBasedOn(brands: [String?], filterData: [FilterData], selectedFilterData: SelectedFilterData?) -> SelectedFilterData {
        var accounts = [String?]()
        var locations = [String?]()
        
        // Fetch FilterData Based on Company Name
        if let selectedCompanyHeirarchy = filterData.first(where: { $0.companyName == selectedFilterData?.companyName })?.hierarchy {
            // Filter Data based on Brand, AccountID, and Location
            for heirarchy in selectedCompanyHeirarchy {
                // Check if Brand Matches
                let brandsList = heirarchy.brandNameList ?? []
                for brand in brandsList {
                    let locationList = brand.locationNameList ?? []
                    for location in locationList {
                        if (brands.contains(brand.brandName ?? "")) {
                            
                            if !accounts.contains(heirarchy.accountNumber) {
                                accounts.append(heirarchy.accountNumber)
                            }
                            
                            if !locations.contains(location.locationName) {
                                locations.append(location.locationName)
                            }
                        }
                    }
                }
            }
        }
        return SelectedFilterData(companyName: selectedFilterData?.companyName ?? "", accounts: accounts, brands: brands, locations: locations)
    }
    
    static func fetchBasedOn(locations: [String?], filterData: [FilterData], selectedFilterData: SelectedFilterData?) -> SelectedFilterData {
        var accounts = [String?]()
        var brands = [String?]()
        
        // Fetch FilterData Based on Company Name
        if let selectedCompanyHeirarchy = filterData.first(where: { $0.companyName == selectedFilterData?.companyName })?.hierarchy {
            // Filter Data based on Brand, AccountID, and Location
            for heirarchy in selectedCompanyHeirarchy {
                // Check if Brand Matches
                let brandsList = heirarchy.brandNameList ?? []
                for brand in brandsList {
                    let locationList = brand.locationNameList ?? []
                    for location in locationList {
                        if (locations.contains(location.locationName ?? "")) {
                            if !accounts.contains(heirarchy.accountNumber) {
                                accounts.append(heirarchy.accountNumber)
                            }
                            
                            if !brands.contains(brand.brandName) {
                                brands.append(brand.brandName)
                            }
                        }
                    }
                }
            }
        }
        return SelectedFilterData(companyName: selectedFilterData?.companyName ?? "", accounts: accounts, brands: brands, locations: locations)
    }
}

protocol CompanyDelegate: AnyObject {
    func didTapCompany(name: SelectedFilterData?)
}

