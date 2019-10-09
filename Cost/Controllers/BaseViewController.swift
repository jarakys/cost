//
//  BaseViewController.swift
//  Cost
//
//  Created by Dmitriy Chumakov on 9/16/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ConfigurableNavigationBar {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
//        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.shadowColor = .white
            app.shadowImage = UIImage()
            app.backgroundColor = .white
            app.backgroundImage = UIImage()
            self.navigationController?.navigationBar.compactAppearance = app
            self.navigationController?.navigationBar.standardAppearance = app
            self.navigationController?.navigationBar.scrollEdgeAppearance = app
        }
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
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
