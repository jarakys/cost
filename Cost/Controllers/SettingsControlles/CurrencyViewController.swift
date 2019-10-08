//
//  CurrencyViewController.swift
//  Cost
//
//  Created by Kirill on 9/30/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class CurrencyViewController: BaseSettingsViewController {

    override var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
    
    let storageManager = StorageManager()
    var currencies: [Currency] = []
    let requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if storageManager.getData(key: .currencyList) == nil {
            requestManager.getCurrency(action: {response in
                self.currencies = try! JSONDecoder().decode([Currency].self, from: response.data!)
                let json = try! JsonConverter.toString(value: response.value)
                self.storageManager.saveData(data: json, key: .currencyList)
                self.tableView.reloadData()
                self.setSelectedCurrency()
            })
        }
        else {
            let json = storageManager.getData(key: .currencyList)
            currencies = JsonConverter.jsonToObject(stringJson: json!)
            self.setSelectedCurrency()
        }
        
    }
    
    override func configureTableViewHeight() {
        
    }
    
    private func setSelectedCurrency() {
        let selectedCurrency = Int(storageManager.getData(key: .currency)!)!
        tableView.selectRow(at: IndexPath(row: selectedCurrency, section: 0), animated: true, scrollPosition: .none)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrencyViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = currencies[indexPath.row].id
        }
        // Configure the cell...
        
        return cell
    }
    
    
}

extension CurrencyViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storageManager.saveData(data: indexPath.row.description, key: .currency)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
