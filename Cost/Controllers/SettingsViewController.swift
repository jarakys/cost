//
//  SettingsViewController.swift
//  Cost
//
//  Created by Dmitriy Chumakov on 9/16/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class SettingsViewController: BaseSettingsViewController {

    let settingsText = ["Currency","Week starts on", "Language"]
    
    override var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorInset = .zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension SettingsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = settingsText[indexPath.row]
        }
        return cell
    }
    
    
}

extension SettingsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch settingsText[indexPath.row] {
        case settingsText[0]:
            self.performSegue(withIdentifier: "currency", sender: nil)
        case settingsText[1]:
            self.performSegue(withIdentifier: "weekStart", sender: nil)
        case settingsText[2]:
            self.performSegue(withIdentifier: "languages", sender: nil)
            
        default:
            print("incorrect identifier")
        }
    }
    
}
