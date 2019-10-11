//
//  CategoryViewController.swift
//  Cost
//
//  Created by Kirill on 9/20/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit
import SVGKit
class CategoryViewController: BaseViewController {

    
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            self.categoryCollectionView.dataSource = self
            self.categoryCollectionView.delegate = self
        }
    }
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var moneyTextField: UITextField! {
        didSet {
            self.moneyTextField.delegate = self
        }
    }
    
    private var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            return 0// Fallback on earlier versions
        }
    }
    
    private weak var currentCell: CategoryCollectionViewCell?
    var currentCategory: Category = .Earn
    private var selectedSubCategory: UserCategories?
    private let buttonTitles = [Category.Earn.string().uppercased(),Category.Costs.string().uppercased()]
    private let requestManager = RequestManager()
    private let storageManager = StorageManager()
    private var categories = UserCategories.allCases
    private var selectedCategoryIndex:Int = 0
    private var selectedCurrency: Currency!
    @IBOutlet weak var segmenetControlView: SegmentControlView! {
        didSet {
            self.segmenetControlView.delegate = self
            self.segmenetControlView.buttonBackgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
            self.segmenetControlView.setButtonTitiles(buttonTitiles: buttonTitles)
            self.segmenetControlView.textColor = .lightGray
            self.segmenetControlView.selectorTextColor = .black
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(categories)
        configureUI()
        updateColorUI()
        categoryCollectionView.reloadData()
        moneyTextField.layer.cornerRadius = 20
        moneyTextField.layer.masksToBounds = true
        moneyTextField.returnKeyType = .done
        addDoneButtonOnKeyboard()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: moneyTextField.frame.size.height))
        moneyTextField.leftView = paddingView
        moneyTextField.leftViewMode = .always
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let currenciesJSON = storageManager.getData(key: .currencyList) else { showAlert(title: "Error", message: "Select your currency in Settings"); return }
        let currencies:[Currency] = JsonConverter.jsonToObject(stringJson: currenciesJSON)!
        let currencyIndex = Int(storageManager.getData(key: .currency)!)!
        selectedCurrency = currencies[currencyIndex]
        currencyLabel.text = selectedCurrency.id
    }
    
    override func configureNavigationBar() {
        let color = currentCategory.color()
        self.navigationItem.title = "NEW " + currentCategory.string()
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color]
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


extension CategoryViewController : SegmentControlDelegate{
    
    func changeToIndex(index: Int) {
        currentCategory = Category(rawValue: index+1)!
        updateColorUI()
        configureNavigationBar()
        
    }

}

//Configurations
extension CategoryViewController {
    func configureUI() {
        segmenetControlView.roundCorners([.topLeft, .topRight], radius: 50)
        segmenetControlView.layer.masksToBounds = false
        segmenetControlView.layer.shadowRadius = 4
        segmenetControlView.layer.shadowOpacity = 5
        segmenetControlView.layer.shadowColor = UIColor.blue.cgColor
        segmenetControlView.layer.shadowOffset = CGSize(width: 0 , height:2)
        let index = buttonTitles.firstIndex(of: currentCategory.string().uppercased())!
        segmenetControlView.setIndex(index: index)
        // segmenetControlView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
    }
}

//Update view
extension CategoryViewController {
    private func updateColorUI() {
        let color = currentCategory.color()
        segmenetControlView.selectorViewColor = color
        currentCell?.colorSelectedItem = color
        makePrefix(prefix: selectedSubCategory?.string() ?? "")
        currencyLabel.textColor = color
    }
    func makePrefix(prefix: String) {
        let attributedString = NSMutableAttributedString(string: prefix + ": ")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:  currentCategory.color() , range: NSMakeRange(0, prefix.count+2))
        moneyTextField.attributedText = attributedString
        moneyTextField.textColor = currentCategory.color()
    }
}

extension CategoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        if let image = cell.viewWithTag(1) as? UIImageView {
            image.image = UIImage(named: categories[indexPath.row].image())?.withRenderingMode(.alwaysTemplate)
        }
        if let label = cell.viewWithTag(2) as? UILabel {
            label.text = categories[indexPath.row].string()
        }
        return cell
    }
}

extension CategoryViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.colorSelectedItem = currentCategory.color()
        currentCell = cell
        selectedCategoryIndex = indexPath.row
        selectedSubCategory = categories[indexPath.row]
        makePrefix(prefix: selectedSubCategory!.string())
    }
}

//KEYBOARD extension
extension CategoryViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == topbarHeight {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
          let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        moneyTextField.inputAccessoryView = doneToolbar
      }

      @IBAction func changeCurrencyAction(_ sender: Any) {
          self.performSegue(withIdentifier: "showCurrencyMenu", sender: nil)
      }

      @objc func doneButtonAction() {
        moneyTextField.resignFirstResponder()
        let userJson = storageManager.getData(key: .user)!
        let user:UserModel = JsonConverter.jsonToObject(stringJson: userJson)
        var model: BaseDailyModel!
        guard let countMoney = moneyTextField.text else {
            showAlert(title: "Error", message: "Enter value")
            return
        }
        guard  moneyTextField!.text != nil  else {
            showAlert(title: "Error", message: "Enter value")
            return
        }
        guard selectedSubCategory != nil else {
            showAlert(title: "Error", message: "Select category")
            return
        }
        guard selectedCurrency != nil else {
             showAlert(title: "Error", message: "Select your currency in Settings"); return
        }
        let moneyText = countMoney.replacingOccurrences(of: selectedSubCategory!.string()+": ", with: "")
        switch currentCategory {
        case .Costs:
            model = CostsModel(categoryId: selectedCategoryIndex.description, date: Date().getDescription(formattingStyle: "YYYY/MM/dd"), description: "", currencyBase: selectedCurrency.id, currency: "EUR", costs: moneyText)
        case .Earn:
            model = EarnModel(categoryId: selectedCategoryIndex.description, date: Date().getDescription(formattingStyle: "YYYY/MM/dd"), description: "", currencyBase: "EUR" , currency: selectedCurrency.id, earn: moneyText)
        case .Balance:
            break
        }
        debugPrint(user.token)
        requestManager.sendDailyReport(model: model, token: user.token, complition: {response in
                debugPrint(response)
        })
      }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != topbarHeight {
            self.view.frame.origin.y = topbarHeight
        }
    }
}



extension CategoryViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let protectedRange = NSMakeRange(0, (selectedSubCategory?.string().count ?? -2)+2)
        let intersection = NSIntersectionRange(protectedRange, range)
        if intersection.length > 0 {
            return false
        }
        return true
    }
}
