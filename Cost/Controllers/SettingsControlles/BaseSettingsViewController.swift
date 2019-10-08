//
//  BaseSettingsViewController.swift
//  Cost
//
//  Created by Kirill on 9/28/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class BaseSettingsViewController: BaseViewController, ConfigurableTableViewHeight {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewHeight()
        // Do any additional setup after loading the view.
    }
    
    
    
    func configureTableViewHeight() {
        var rectFrame = tableView.frame
        print(tableView.contentSize.height)
        rectFrame.size.height = tableView.contentSize.height
        tableView.frame = rectFrame
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        configureTableViewHeight()
    }

    override func configureNavigationBar() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
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
