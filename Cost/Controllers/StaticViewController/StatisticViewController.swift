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
    
    @IBOutlet weak var indicator: UIView!
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
            self.segmentControlView.setButtonTitiles(buttonTitiles: [IterableDate.day.string(),IterableDate.week.string(),IterableDate.month.string()])
            let color = currentCategory.color()
            self.segmentControlView.textColor = .lightGray
            self.segmentControlView.selectorTextColor = .black
            self.segmentControlView.selectorViewColor = color
        }
    }
    
    var dataOne = PieChartDataEntry(value: 0, label: "", data: "")
    private var dataTwo = PieChartDataEntry(value: 0, label: "Буд")
    private var dataThree = PieChartDataEntry(value: 0, label: "Буд")
    private var categoryLenend = [PieChartDataEntry]()
    
    private var statistic:Statistic?
    
    private var statTest:[StatisticItem] = []
    private var source:[StatisticItem] = []
    private let storageManager = StorageManager()
    private let requestManager = RequestManager()
    var currentCategory: Category = .Balance
    private var iterableThrought: IterableDate = .day
    private var firstDayInWeek: DaysOfWeek!
    private var startDate = Date()
    private var endDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDayInWeek =  DaysOfWeek(rawValue: Int(storageManager.getData(key: .weekStartOn)!)!)
        setDate(value: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        self.navigationController?.navigationBar.tintColor = currentCategory.color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
    }
    
    deinit {
        print("deinit")
    }

    
    func configureUI(count: String) {
        value.text = count + " €"
        value.textColor = currentCategory.color()
        category.text = currentCategory.string()
    }

}

// Configurations
extension StatisticViewController {
    private func configurePieChart(source: Statistic) {
        let earned = source.dailyReportItem.reduce(0, { (result, item) -> Float in
            if item.costs == 0 {
                return result + item.income
            }
            return result
        })
        
        let costs = source.dailyReportItem.reduce(0, { (result, item) -> Float in
            if item.income == 0 {
                return result + item.costs
            }
            return result
        })
        
        print(earned-costs)
         print(costs)
         print(earned)
        
        dataOne.value = Double((earned-costs) != 0 ? (earned-costs) : 30)
        dataTwo.value =  Double(costs != 0 ? costs : 30)
        dataThree.value = Double(earned != 0 ? costs : 30)
        chart.drawMarkers = false
        chart.usePercentValuesEnabled = true
        chart.backgroundColor = .white
        chart.layer.masksToBounds = true
        chart.layer.cornerRadius = 10
        chart.rotationEnabled = false
        categoryLenend = [dataOne,dataTwo,dataThree]
        let charDataSet = PieChartDataSet(entries: categoryLenend, label: nil)
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
    
    private func updateTableViewSource(data: Statistic) {
        switch currentCategory {
        case .Balance:
            source = data.dailyReportItem
        case .Costs:
            source = data.dailyReportItem.filter {
                $0.income == 0 && $0.costs > 0
            }
        case .Earn:
            source = data.dailyReportItem.filter{
                $0.income > 0 && $0.costs == 0
            }
        }
        categoryTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.indicator.removeBluerLoader()
        })
    }
    
    private func updateChartData() {
        let json  = storageManager.getData(key: .user)
        let user: UserModel = JsonConverter.jsonToObject(stringJson: json!)!
        requestManager.getStatistics(dateStart: startDate, dateEnd: endDate, statisticType: Category.Balance, token: user.token) {[unowned self] response  in
            
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Check internet connection")
                self.indicator.removeBluerLoader()
            case .success:
                if response.response?.statusCode == 200 {
                    let statisticJson = try! JsonConverter.toString(value: response.value)
                    let source:Statistic = JsonConverter.jsonToObject(stringJson: statisticJson)
                    self.configurePieChart(source: source)
                }
                else {
                    self.showAlert(title: "Error", message: "Server Error")
                    self.indicator.removeBluerLoader()
                }
            }
        }
    }
    
    private func updateTableData() {
        indicator.showBlurLoader()
        
        let json  = storageManager.getData(key: .user)
        let user: UserModel = JsonConverter.jsonToObject(stringJson: json!)!
        requestManager.getStatistics(dateStart: startDate, dateEnd: endDate, statisticType: currentCategory, token: user.token) {[unowned self] response  in
            
            switch response.result {
            case .failure:
                self.showAlert(title: "Error", message: "Check internet connection")
                self.indicator.removeBluerLoader()
            case .success:
                if response.response?.statusCode == 200 {
                    let statisticJson = try! JsonConverter.toString(value: response.value)
                    self.statistic = JsonConverter.jsonToObject(stringJson: statisticJson)
                    self.updateTableViewSource(data: self.statistic!)
                    self.configureUI(count: self.statistic!.totalCost.description)
                }
                else {
                    self.showAlert(title: "Error", message: "Server Error")
                    self.indicator.removeBluerLoader()
                }
            }
        }
    }    
}

// Actions
extension StatisticViewController {

    @IBAction func chartClicj(_ sender: Any) {
        currentCategory = Category(rawValue: currentCategory.index() >= Category.allCases.count - 1 ? 0 : currentCategory.index()+1)!
        updateUI()
        updateTableData()
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
            startDate = Date().getDateByOffset(offset: value)
            endDate = startDate
            title = startDate.getDescription()
            
        case .month:
            break
        case .week:
            let date = Date().addDaysToDate(weekOffset: value).startAndEndOfWeek(dayOfWeek: firstDayInWeek)
            startDate = date.start
            endDate = date.end
            title = startDate.getDescription() + "-" + endDate.getDescription()
        }
        sjStepperView.setTitle(text: title)
        updateTableData()
        updateChartData()
    }
    
}


extension StatisticViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        if let label = cell.viewWithTag(1) as? UILabel {
            label.textColor = setColor(item: source[indexPath.row])
            label.text = UserCategories.allCases[source[indexPath.row].categoryName].string()
        }
        if let image = cell.viewWithTag(2) as? UIImageView {
            image.image =  UIImage(named:UserCategories.allCases[source[indexPath.row].categoryName].image())?.withRenderingMode(.alwaysTemplate)
            image.tintColor = setColor(item: source[indexPath.row])
        }
        if let money = cell.viewWithTag(3) as? UILabel {
            money.text = source[indexPath.row].costs == 0 ? source[indexPath.row].income.description :  source[indexPath.row].costs.description
            money.text! += " €"
        }
        return cell
        
    }
    
    private func setColor(item: StatisticItem) ->UIColor {
        if item.costs == 0 {
            return Category.Earn.color()
        }
        else {
            return Category.Costs.color()
        }
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

