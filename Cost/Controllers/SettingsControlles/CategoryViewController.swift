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
        }
    }
    var currentCategory: Category = .Earn
    let buttonTitles = [Category.Earn.string().uppercased(),Category.Costs.string().uppercased()]
    let networkManager = RequestManager()
    var categories = UserCategories.allCases
    @IBOutlet weak var segmenetControlView: SegmentControlView! {
        didSet {
            self.segmenetControlView.delegate = self
            self.segmenetControlView.buttonBackgroundColor = UIColor(red:0.97, green:0.97, blue:0.98, alpha:1.0)
            self.segmenetControlView.setButtonTitiles(buttonTitiles: buttonTitles)
            let color = currentCategory.color()
            self.segmenetControlView.textColor = .lightGray
            self.segmenetControlView.selectorTextColor = .black
            self.segmenetControlView.selectorViewColor = color
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(categories)
        configureUI()
        categoryCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    }
}

extension CategoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        if let image = cell.viewWithTag(1) as? UIImageView {
            image.image = UIImage(named: categories[indexPath.row].image())?.withRenderingMode(.alwaysTemplate)
        }
        if let label = cell.viewWithTag(2) as? UILabel {
            label.text = categories[indexPath.row].string()
        }
        return cell
    }
}
