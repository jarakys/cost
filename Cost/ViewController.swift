//
//  ViewController.swift
//  Cost
//
//  Created by Dmitriy Chumakov on 9/16/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit
import Charts

class ViewController: BaseViewController {

    @IBOutlet weak var symbolImage: UIImageView!
    @IBOutlet weak var cardMoneyLabel: UILabel!
    @IBOutlet weak var moneyBottomLabel: UILabel!
    @IBOutlet weak var floatButton: UIButton!
    @IBOutlet weak var cardDate: UILabel!
    @IBOutlet weak var categoryImageVIew: UIImageView!
    @IBOutlet weak var segmentControlView: SegmentControlView! {
        didSet {
            self.segmentControlView.setButtonTitiles(buttonTitiles: [Category.Balance.string(),Category.Earn.string(),Category.Costs.string()])
            self.segmentControlView.delegate = self
            let color = currentCategory.color()
            self.segmentControlView.textColor = .lightGray
            self.segmentControlView.selectorTextColor = .black
            self.segmentControlView.selectorViewColor = color
            
        }
    }
    
    @IBOutlet weak var lineChart: LineChartView!
    
    private var stepper: SJStepperView!
    private var lineChartDataSet: LineChartDataSet!
    private var lineChartData: LineChartData!
    private var currentCategory = Category.Balance
    private let requestManager = RequestManager()
    private let storageManager = StorageManager()
    private var selectedDate: Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = currentCategory.color()
        floatButton.backgroundColor = color
        configureChart()
        getData()
    }
    
    override func configureNavigationBar() {
        let color = currentCategory.color()
        self.navigationController!.navigationBar.tintColor = color
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stepper = SJStepperView()
        stepper.upButtonImage = UIImage(named: "up")
        stepper.downButtonImage = UIImage(named: "down")
        stepper.setup(title: "Urur", stepperColor: currentCategory.color())
        stepper.delegate = self
        navigationItem.titleView = stepper
        setDate(value: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StatisticViewController {
            vc.currentCategory = self.currentCategory
        }
        else if let vc = segue.destination as? CategoryViewController {
            vc.currentCategory = self.currentCategory
        }
    }
    
    private func getData() {
        let json  = storageManager.getData(key: .user)
        let user: UserModel = JsonConverter.jsonToObject(stringJson: json!)!
        requestManager.getStatistics(dateStart: selectedDate, dateEnd: selectedDate, statisticType: currentCategory, token: user.token, complition: { response in
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Check internet connection")
            case .success:
                if response.response?.statusCode == 200 {
                    debugPrint(response)
                    let statisticJson = try! JsonConverter.toString(value: response.value)
                    let statistic:Statistic = JsonConverter.jsonToObject(stringJson: statisticJson)
                    self.updateMoneyLabel(value: statistic.totalCost.description)
                }
                else {
                    debugPrint(response)
                    self.showAlert(title: "Error", message: "Server Error")
                }
            }
        })
    }
    
}

extension ViewController {
    private func configureChart() {
        let values = (40..<50).map{(i)-> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(50))+3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        lineChartDataSet = LineChartDataSet(entries: values, label: "")
        lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        let gradientColors = [currentCategory.color().cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 100) // Set the Gradient
        lineChartDataSet.drawFilledEnabled = true // Draw the Gradient
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.setColor(currentCategory.color())
        lineChartDataSet.lineWidth = 2
        lineChart.borderLineWidth = 3
        lineChart.legend.enabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawLabelsEnabled = false
        lineChart.drawGridBackgroundEnabled = false
        lineChart.drawBordersEnabled = false
        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawLabelsEnabled = false
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        lineChart.rightAxis.removeAllLimitLines()
        lineChart.xAxis.removeAllLimitLines()
        lineChart.rightAxis.removeAllLimitLines()
        lineChart.isUserInteractionEnabled = false
        lineChart.minOffset = 0
        self.lineChart.data = lineChartData
    }
}


extension ViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        currentCategory = Category(rawValue: index)!
        configureNavigationBar()
        updateViewVisible()
        updateUIColor()
        updateImage()
        updateChartDataSource()
        getData()
    }
}
//Updates View
extension ViewController {
    private func updateImage() {
        categoryImageVIew.image = currentCategory.cardImage()
        symbolImage.image = currentCategory.arrowImage()
    }
    
    private func updateUIColor() {
        let color = currentCategory.color()
        segmentControlView.selectorViewColor = color
        floatButton.backgroundColor = currentCategory.color()
        stepper.stepperColor = color
        lineChartDataSet.setColor(currentCategory.color())
        moneyBottomLabel.textColor = color
        let gradientColors = [currentCategory.color().cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        UIView.animate(withDuration: 0.3) {
            self.lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 100)
        }
        // Set the Gradient
    }
    
    private func updateMoneyLabel(value: String) {
        cardMoneyLabel.text = value
        moneyBottomLabel.text = value + " €"
    }
    
    private func updateViewVisible() {
        switch currentCategory {
        case .Balance:
            self.floatButton.alpha = 0
            self.floatButton.isHidden = true
            self.lineChart.alpha = 0
        case .Costs:
            fallthrough
        case .Earn:
            UIView.animate(withDuration: 0.3, animations:{
                self.floatButton.alpha = 1
                self.lineChart.alpha = 1
            })
            self.floatButton.isHidden = false
        }
    }
    
    private func updateChartDataSource() {
        lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
    }
    
    private func setDate(value: Int) {
        selectedDate = Date().getDateByOffset(offset: value)
        let title = selectedDate.getDayOfWeek() + " " + selectedDate.getDescription()
        stepper.setTitle(text:title )
        cardDate.text = title
        getData()
    }
    
}

extension ViewController : SJStepperViewDelegate {
    func downButtonTapped(value: Int) {
        setDate(value: value)
    }
    
    func upButtonTapped(value: Int) {
        setDate(value: value)
    }
    
    
}
