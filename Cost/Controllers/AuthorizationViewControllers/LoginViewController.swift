//
//  LoginViewController.swift
//  Cost
//
//  Created by Kirill on 10/1/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Log in"
        passwordField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0), width: 1)
        usernameField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0), width: 1)
        navItemApperace()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        //
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "mainController")
        if passwordField.text == "" || usernameField.text == "" {
            showAlert(title: "Error", message: "Empty fields")
            return
        }
        let user = UserLoginModel(email: usernameField.text!, password: passwordField.text!, accountType: 1)
        let requestManager = RequestManager()
        self.view.showBlurLoader()
        requestManager.logIn(user: user, complition: {response in
            debugPrint(response)
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Server not available")
            case .success:
                if response.response?.statusCode == 200 {
                    let json  = try! JsonConverter.toString(value: response.value!)
                    let storageManager = StorageManager()
                    storageManager.saveData(data: json, key: .user)
                    self.navigationController?.pushViewController(vc, animated: true)
                    return
                }
                else if response.response?.statusCode == 404 {
                    self.showAlert(title: "Error", message: "User not exist")
                }
                else {
                    let json = (response.value as! [String: Any])["errors"] as! [String:[Any]]
                    print(Utils.getStringFromDictionary(dictionary: json))
                    let errorMessage = Utils.getStringFromDictionary(dictionary: json)
                    self.showAlert(title: "Error", message: errorMessage)
                }
            }
            self.view.removeBluerLoader()
        })
    }
    

    private func navItemApperace() {
                if #available(iOS 13.0, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.backgroundColor = .white
                    appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red:0.44, green:0.47, blue:0.51, alpha:1.0)]
                    appearance.shadowColor = .white
                    appearance.shadowImage = UIImage()
                    appearance.backgroundColor = .white
                    appearance.backgroundImage = UIImage()
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                    self.navigationController?.navigationBar.standardAppearance = appearance
                    self.navigationController?.navigationBar.compactAppearance = appearance
                    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
                    
                }
                self.navigationController?.view.backgroundColor = .white
                self.navigationController?.navigationBar.prefersLargeTitles = true
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
