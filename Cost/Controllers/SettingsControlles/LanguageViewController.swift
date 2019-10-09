//
//  LanguageViewController.swift
//  Cost
//
//  Created by Kirill on 9/29/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class LanguageViewController: BaseSettingsViewController {

    private var storageManager: StorageManager! = StorageManager()
    
    override var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
    
    let languages = ["English","Arabic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedLanguage()
        // Do any additional setup after loading the view.
    }
    
    private func setSelectedLanguage() {
        let selectedLanguage = Int(storageManager.getData(key: .language)!)!
        tableView.selectRow(at: IndexPath(row: selectedLanguage, section: 0), animated: true, scrollPosition: .none)
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

extension LanguageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = languages[indexPath.row]
        }
        return cell
    }
}

extension LanguageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storageManager.saveData(data: indexPath.row.description, key: .language)
        if indexPath.row == 0 {
            Bundle.setLanguage(lang: "en")
        }
        else {
            Bundle.setLanguage(lang: "ar")
        }
        
    }
}
