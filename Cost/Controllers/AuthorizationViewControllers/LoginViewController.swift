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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        return
        
        if passwordField.text == "" || usernameField.text == "" {
            showAlert(title: "Error", message: "Empty fields")
            return
        }
        
        let user = UserLoginModel(email: usernameField.text!, password: passwordField.text!, accountType: 1)
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(user)
//        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        let requestManager = RequestManager()
        self.view.showBlurLoader()
        requestManager.logIn(user: user, complition: {response in
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Server not available")
            case .success:
                if response.response?.statusCode == 200 {
                    let json  = try! JsonConverter.toString(value: response.value!)
                    let storageManager = StorageManager()
                    storageManager.saveData(data: json, key: .user)
                    //self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
