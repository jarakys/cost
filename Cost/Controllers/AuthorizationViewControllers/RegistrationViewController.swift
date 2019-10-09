//
//  RegistrationViewController.swift
//  Cost
//
//  Created by Kirill on 10/1/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
    @IBAction func registerAction(_ sender: Any) {
        let requestManager  = RequestManager()
    
        if  usernameField.text == "" || emailField.text == "" || passwordField.text == "" {
            showAlert(title: "Error", message: "Empty fields")
            return
        }
        let user = UserRegistrationModel(email: emailField.text!, password: passwordField.text!, name: usernameField.text!, accountType: 1)
//        print(user)
//
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try! jsonEncoder.encode(user)
//        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        self.view.showBlurLoader()
        requestManager.register(user: user , complition: { response  in
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Server not available")
            case .success:
                if response.response?.statusCode == 200 {
                    self.performSegue(withIdentifier: "loginUnwingSegue", sender: nil)
                }
                else {
                    let json = (response.value as! [String: Any])["errors"] as! [String:[Any]]
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
