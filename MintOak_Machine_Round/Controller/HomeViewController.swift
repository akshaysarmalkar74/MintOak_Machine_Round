//
//  ViewController.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: Variables
    var midNumsList = [String?]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tblView.reloadData()
            }
        }
    }
    var allData = [FilterData]()
    private var selectedFilterData: SelectedFilterData?

    // MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTblView()
        setupData()
    }

}

// MARK: IBActions

extension HomeViewController {
    @IBAction func didTapChangeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let filterViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filterViewController.allData = allData
        filterViewController.selectedFilterData = selectedFilterData
        filterViewController.modalPresentationStyle = .overCurrentContext
        self.present(filterViewController, animated: true)
    }
}

// MARK: Helper Methods

extension HomeViewController {
    private func configureTblView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: String.className(MIDTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(MIDTableViewCell.self))
    }
    
    private func setupData() {
        // Fetch Data and Store it in allData
        let dataFetcher = DataFetcher(fileName: "Data")
        allData = dataFetcher.readJSON(type: FilterDataResponse.self)?.filterData ?? []
        selectedFilterData = SelectedFilterData(
            companyName: allData.first?.companyName ?? "", // Showing First Company as PreSelected
            accounts: DataFetcher.fetchAllAccounts(filterData: allData[0]),
            brands: DataFetcher.fetchAllBrands(filterData: allData[0]),
            locations: DataFetcher.fetchAllLocations(filterData: allData[0])
        )
        
        lblCompanyName.text = selectedFilterData?.companyName
        midNumsList = DataFetcher.fetchMIDNumbers(filterData: allData, selectedFilterData: selectedFilterData!) // Force Unwrapping as we are sure that value will exists
    }
}

// MARK: UITableViewDataSource Methods

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        midNumsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(MIDTableViewCell.self), for: indexPath) as! MIDTableViewCell
        cell.configureData(midValue: midNumsList[indexPath.row])
        return cell
    }
    
}

// MARK: UITableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

