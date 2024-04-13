//
//  FilterViewController.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedFilterData: SelectedFilterData? {
        didSet {
            someData = [
                .account(num: selectedFilterData?.accounts.count ?? 0),
                .brand(num: selectedFilterData?.brands.count ?? 0),
                .location(num: selectedFilterData?.locations.count ?? 0)
            ]
        }
    }
    var allData = [FilterData]()
    var someData = [FilterTypes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTblView()
        configureCollectionView()
    }
    
    private func configureTblView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: String.className(FilterTypeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(FilterTypeTableViewCell.self))
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String.className(CompanyCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String.className(CompanyCollectionViewCell.self))
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: CollectionView Methods

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.className(CompanyCollectionViewCell.self), for: indexPath) as! CompanyCollectionViewCell
        let companyName = allData[indexPath.row].companyName
        cell.configureData(name: companyName, isSelected: companyName == selectedFilterData?.companyName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterData = allData[indexPath.row]
        selectedFilterData = SelectedFilterData(
            companyName: filterData.companyName ?? "",
            accounts: DataFetcher.fetchAllAccounts(filterData: filterData),
            brands: DataFetcher.fetchAllBrands(filterData: filterData),
            locations: DataFetcher.fetchAllLocations(filterData: filterData)
        )
        collectionView.reloadData()
        tblView.reloadData()
    }
}

// MARK: UITableView Extensions

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        someData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(FilterTypeTableViewCell.self), for: indexPath) as! FilterTypeTableViewCell
        cell.configureData(type: someData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Some Row Tapped")
    }
}
