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
    }
    
    func configureNavigationBar() {
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
    }

}
