//
//  StatisticViewController.swift
//  Cost
//
//  Created by Kirill Chernov on 9/16/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit
import Charts
class StatisticViewController: BaseViewController {
    
    @IBOutlet weak var chart: PieChartView!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var categoryTableView: UITableView! {
        didSet {
            self.categoryTableView.dataSource = self
            self.categoryTableView.delegate = self
        }
    }
    @IBOutlet weak var sjStepperView: SJStepperView! {
        didSet {
            self.sjStepperView.upButtonImage = UIImage(named: "up")
            self.sjStepperView.downButtonImage = UIImage(named: "down")
            self.sjStepperView.title = "Hi"
            self.sjStepperView.delegate = self
            self.sjStepperView.stepperColor = .lightGray
        }
    }
    
    @IBOutlet weak var segmentControlView: SegmentControlView! {
        didSet {
            self.segmentControlView.delegate = self
            self.segmentControlView.setButtonTitiles(buttonTitiles: ["TODAY","WEEK","MONTH"])
            let color = currentCategory.color()
            self.segmentControlView.textColor = .lightGray
            self.segmentControlView.selectorTextColor = .black
            self.segmentControlView.selectorViewColor = color
        }
    }
    
    var iterableThrought: Calendar.Component = .day
    var dataOne = PieChartDataEntry(value: 0, label: "", data: "")
    var dataTwo = PieChartDataEntry(value: 0, label: "Буд")
    var dataThree = PieChartDataEntry(value: 0, label: "Буд")
    var numberOfDown = [PieChartDataEntry]()
    var testValue = ["1200  \n BALANCE","300 \n EARN","250 \n COSTS"]
    var statTest = [Statistic(id: 1, income: 145, costs: 0, category:"Computer"), Statistic(id: 2, income: 123, costs: 0, category: "Job"), Statistic(id: 3, income: 0, costs: 123, category: "Eat"), Statistic(id: 4, income: 0, costs: 133, category: "Car")]
    var source = [Statistic(id: 1, income: 145, costs: 0, category:"Computer"), Statistic(id: 2, income: 123, costs: 0, category: "Job"), Statistic(id: 3, income: 0, costs: 123, category: "Eat"), Statistic(id: 4, income: 0, costs: 133, category: "Car")]
    var currentCategory: Category = .Balance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSource()
        configureUI()
        configurePieChart()
        // Do any additional setup after loading the view.
    }
    
    override func configureNavigationBar() {
        self.navigationController?.navigationBar.tintColor = currentCategory.color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
    }

    
    func configureUI() {
        value.text = "120.00"
        value.textColor = currentCategory.color()
        category.text = currentCategory.string()
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

// Configurations
extension StatisticViewController {
    private func configurePieChart() {
        dataOne.value = 20
        dataTwo.value = 50
        dataThree.value = 33
        chart.drawMarkers = false
        chart.usePercentValuesEnabled = true
        chart.backgroundColor = .white
        chart.layer.masksToBounds = true
        chart.layer.cornerRadius = 10
        chart.rotationEnabled = false
        numberOfDown = [dataOne,dataTwo,dataThree]
        let charDataSet = PieChartDataSet(entries: numberOfDown, label: nil)
        
        let chartData = PieChartData(dataSet: charDataSet)
        let colors = [Category.Balance.color(),Category.Costs.color(), Category.Earn.color()]
        charDataSet.colors = colors
        charDataSet.drawValuesEnabled = false
        chart.drawSlicesUnderHoleEnabled = false
        chart.drawEntryLabelsEnabled = false
        chart.holeRadiusPercent = 0.8
        chart.legend.enabled = false
        chart.data = chartData
    }
    
    private func updateSource(){
        switch currentCategory {
        case .Balance:
            source = statTest
        case .Costs:
            source = statTest.filter {
                $0.income == 0 && $0.costs > 0
            }
        case .Earn:
            source = statTest.filter{
                $0.income > 0 && $0.costs == 0
            }
        }
    }
}

// Actions
extension StatisticViewController {

    @IBAction func chartClicj(_ sender: Any) {
        currentCategory = Category(rawValue: currentCategory.index() >= testValue.count-1 ? 0 : currentCategory.index()+1)!
        updateUI()
        updateSource()
        categoryTableView.reloadData()
    }
    
}
//UpdateUI
extension StatisticViewController {
    
    func updateUI() {
        configureNavigationBar()
        value.text = "120.00"
        let color = currentCategory.color()
        value.textColor = color
        category.text = currentCategory.string()
        segmentControlView.selectorViewColor = color
    }
    
}


extension StatisticViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        if let label = cell.viewWithTag(1) as? UILabel {
            label.textColor = currentCategory.color()
            label.text = source[indexPath.row].category
        }
        return cell
        
    }
}

extension StatisticViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension StatisticViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        
    }
}

extension StatisticViewController : SJStepperViewDelegate {
    func downButtonTapped(value: String) {
        sjStepperView.setTitle(text: "Titile")
    }
    
    func upButtonTapped(value: String) {
        sjStepperView.iterableThrought = .month
    }
    
    
}
