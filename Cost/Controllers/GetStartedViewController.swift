//
//  GetStartedViewController.swift
//  Cost
//
//  Created by Kirill on 11.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        self.performSegue(withIdentifier: "getStarted", sender: nil)
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
