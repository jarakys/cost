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
        navigationItem.hidesBackButton = true
        navigationItem.title = "Sign Up"
        usernameField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0), width: 1)
        emailField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0), width: 1)
        passwordField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0), width: 1)
        navItemApperace()
         //self.navigationController?.setNavigationBarHidden(true, animated: true)
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
