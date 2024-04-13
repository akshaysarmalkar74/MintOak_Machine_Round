//
//  FilterValueViewController.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 13/04/24.
//

import UIKit

class FilterValueViewController: UIViewController {
    
    @IBOutlet weak var lblSelectVal: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    
    var allValues = [String?]()
    var selectedValues = [String?]()
    var popupType: FilterTypes = .account(num: 0)
    var selectedFilterData: SelectedFilterData?
    var allData = [FilterData]()
    weak var delegate: CompanyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTblView()
        lblSelectVal.text = popupType.displayText
        btnSelectAll.isSelected = allValues.count == selectedValues.count
        setBtnState(!selectedValues.isEmpty)
    }
    
    private func configureTblView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: String.className(FilterSelectTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.className(FilterSelectTableViewCell.self))
    }

    
    @IBAction func didTapSelectAllBtn(_ sender: UIButton) {
        if sender.isSelected {
            // Select All Is Ticked
            selectedValues = []
        } else {
            selectedValues = allValues
        }
        sender.isSelected.toggle()
        btnSelectAll.isSelected = allValues.count == selectedValues.count
        setBtnState(!selectedValues.isEmpty)
        tblView.reloadData()
    }
    
    @IBAction func didTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func didTapApplyButton(_ sender: UIButton) {
        let selectedData: SelectedFilterData?
        switch popupType {
            case .account:
                selectedData = DataFetcher.fetchBasedOn(accountNumber: selectedValues, filterData: allData, selectedFilterData: selectedFilterData)
            case .brand:
                selectedData = DataFetcher.fetchBasedOn(brands: selectedValues, filterData: allData, selectedFilterData: selectedFilterData)
            case .location:
                selectedData = DataFetcher.fetchBasedOn(locations: selectedValues, filterData: allData, selectedFilterData: selectedFilterData)
        }
        delegate?.didTapCompany(name: selectedData)
        self.dismiss(animated: true)
    }
    
    private func setBtnState(_ isUserInteractionEnabled: Bool) {
        applyBtn.isUserInteractionEnabled = isUserInteractionEnabled
        applyBtn.alpha = isUserInteractionEnabled ? 1.0 : 0.5
    }
}

extension FilterValueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(FilterSelectTableViewCell.self), for: indexPath) as! FilterSelectTableViewCell
        let curVal = allValues[indexPath.row]
        cell.configureData(name: curVal ?? "", isSelected: selectedValues.contains(curVal))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if the value exists in Selected Array
        let curValue = allValues[indexPath.row]
        if let indexToRemove = selectedValues.firstIndex(of: curValue) {
            selectedValues.remove(at: indexToRemove)
        } else {
            selectedValues.append(curValue)
        }
        btnSelectAll.isSelected = allValues.count == selectedValues.count
        tblView.reloadData()
        setBtnState(!selectedValues.isEmpty)
    }
}
