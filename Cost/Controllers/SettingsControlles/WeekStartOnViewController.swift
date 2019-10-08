//
//  WeekStartOnViewController.swift
//  Cost
//
//  Created by Kirill on 9/28/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class WeekStartOnViewController: BaseSettingsViewController {
    
    override var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
 
    private var storageManager: StorageManager! = StorageManager()
    let dayOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedDayOfWeek()
        // Do any additional setup after loading the view.
    }
    
//    override func configureNavigationBar() {
//        let color = UIColor.black
//        self.navigationController!.navigationBar.tintColor = color
//        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color]
//    }
    
    
    private func setSelectedDayOfWeek() {
        let selectedDay = Int(storageManager.getData(key: .weekStartOn)!)!
        tableView.selectRow(at: IndexPath(row: selectedDay, section: 0), animated: true, scrollPosition: .none)
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


extension WeekStartOnViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfWeekCell", for: indexPath)
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text  = dayOfWeek[indexPath.row]
        }
        return cell
    }
    
    
}

extension WeekStartOnViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storageManager.saveData(data: indexPath.row.description, key: .weekStartOn)
    }
    
}
