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
    
    var selectedFilterData: SelectedFilterData?
    var allData = [FilterData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
        print("Company Cell Tapped")
    }
}
