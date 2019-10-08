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
            self.sjStepperView.delegate = self
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
    
    var dataOne = PieChartDataEntry(value: 0, label: "", data: "")
    private var dataTwo = PieChartDataEntry(value: 0, label: "Буд")
    private var dataThree = PieChartDataEntry(value: 0, label: "Буд")
    private var numberOfDown = [PieChartDataEntry]()
    private var testValue = ["1200  \n BALANCE","300 \n EARN","250 \n COSTS"]
    private var statTest = [Statistic(id: 1, income: 145, costs: 0, category:"Computer"), Statistic(id: 2, income: 123, costs: 0, category: "Job"), Statistic(id: 3, income: 0, costs: 123, category: "Eat"), Statistic(id: 4, income: 0, costs: 133, category: "Car")]
    private var source = [Statistic(id: 1, income: 145, costs: 0, category:"Computer"), Statistic(id: 2, income: 123, costs: 0, category: "Job"), Statistic(id: 3, income: 0, costs: 123, category: "Eat"), Statistic(id: 4, income: 0, costs: 133, category: "Car")]
    private let storageManager = StorageManager()
    var currentCategory: Category = .Balance
    private var iterableThrought: IterableDate = .day
    private var firstDayInWeek: DaysOfWeek!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSource()
        configureUI()
        configurePieChart()
        firstDayInWeek =  DaysOfWeek(rawValue: Int(storageManager.getData(key: .weekStartOn)!)!)
        setDate(value: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        self.navigationController?.navigationBar.tintColor = currentCategory.color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
    }

    
    func configureUI() {
        value.text = "120.00"
        value.textColor = currentCategory.color()
        category.text = currentCategory.string()
    }

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
    
    private func updateUI() {
        configureNavigationBar()
        value.text = "120.00"
        let color = currentCategory.color()
        value.textColor = color
        category.text = currentCategory.string()
        segmentControlView.selectorViewColor = color
    }
    
    private func setDate(value: Int) {
        var title = ""
        switch iterableThrought {
        case .day:
            title = Date().getDateByOffset(offset: value).getDescription()
        case .month:
            break
        case .week:
            let date = Date().addDaysToDate(weekOffset: value).startAndEndOfWeek(dayOfWeek: firstDayInWeek).start
            print(date)
            title = date.getDescription()
        }
        sjStepperView.setTitle(text: title)
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
        iterableThrought = IterableDate(rawValue: index)!
        sjStepperView.value = 0
        setDate(value: 0)
    }
}

extension StatisticViewController : SJStepperViewDelegate {
    func downButtonTapped(value: Int) {
        setDate(value: value)
    }
    
    func upButtonTapped(value: Int) {
        setDate(value: value)
    }
}

