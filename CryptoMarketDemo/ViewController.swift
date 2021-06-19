//
//  ViewController.swift
//  CryptoMarketDemo
//
//  Created by Ruchin Somal on 2021-06-19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var vm = ViewModel()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Market"
        configureCell()
        getData()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] (timer) in
            self?.getData()
        }
    }
    
    private func getData() {
        vm.fetchData() { [weak self] (status, error) in
            DispatchQueue.main.async {
            if status {
                self?.tblList.reloadData()
            } else {
                print(error?.localizedDescription ?? "")
            }
            }
        }
    }
    
    private func configureCell() {
        tblList.register(UINib(nibName: "MarketElementCell", bundle: Bundle.main), forCellReuseIdentifier: "MarketElementCell")
        tblList.tableFooterView = UIView(frame: .zero)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.arrMarketElement.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.arrMarketElement.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = indexPath.row == 0 ? vm.arrMarketElement[indexPath.row] : vm.arrMarketElement[indexPath.row - 1]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketElementCell", for: indexPath) as? MarketElementCell else {
            return UITableViewCell()
        }
        cell.setupCell(forIndexPath: indexPath, withObject: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        vm.arrMarketElement = vm.storedArr
        self.tblList.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            vm.arrMarketElement = vm.storedArr.filter { $0.name.uppercased().contains(searchText.uppercased())}
            self.tblList.reloadData()
        } else {
            vm.arrMarketElement = vm.storedArr
            self.tblList.reloadData()
        }
    }
}
