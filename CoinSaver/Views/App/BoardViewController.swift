//
//  BoardViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
import Charts

struct DataChange {
    let icon: UIImage?
    let color: UIColor?
}

let up = DataChange(icon: UIImage(named: "arrow_up"), color: UIColor.green)
let down = DataChange(icon: UIImage(named: "arrow_down"), color: UIColor.red)
let flat = DataChange(icon: UIImage(named: "dash"), color: UIColor.yellow)


class BoardViewController: TabItemViewController {

    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
//    circle view elements
    @IBOutlet weak var totalCostsView: UIView!
    @IBOutlet weak var totalSaved: UILabel!
    @IBOutlet weak var changeIcon: UIImageView!
    @IBOutlet weak var percentSaved: UILabel!
    @IBOutlet weak var totalSavedTitle: UILabel!
    @IBOutlet weak var totalCostsTitle: UILabel!
    
    @IBOutlet weak var topCostsPieChart: PieChartView!
    
    var topCostsData:[String:Int] = [:]
    
    override func setupTheme() {
        super.setupTheme()
        totalCostsView.theme.borderColor = themed { $0.black }
        topCostsPieChart.theme.legendTextColor = themed { $0.black }
        totalSaved.theme.textColor = themed { $0.black }
        percentSaved.theme.textColor = themed { $0.black }
        dateLabel.theme.textColor = themed { $0.labelTextColor }
        selectDateButton.theme.tintColor = themed { $0.labelTextColor }
        totalSavedTitle.theme.textColor = themed { $0.black }
        totalCostsTitle.theme.textColor = themed { $0.black }
    }
    
    let chartColors = [
        UIColor.red,
        UIColor.yellow,
        UIColor.green
    ]
    
    var topCostsEntries = [PieChartDataEntry]()
    let ref = FDatabase(email: BasicUserSettings.userEmail)
    @IBAction func selectDate(_ sender: UIButton) {
        let sb = UIStoryboard(name: "DatePickerPopupStoryboard", bundle: nil)
        let popup = sb.instantiateInitialViewController() as! DatePickerPopup
        present(popup, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Board"
        NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) {
            [weak self] (notification) in
                let datePickerPopup = notification.object as! DatePickerPopup
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                self?.dateLabel.text = formatter.string(from: datePickerPopup.datePicker.date)
                var datestr = self?.ref.getDateString(drom: datePickerPopup.datePicker.date) ?? "2020-12"
                self?.updateAllData(datestr: datestr)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateAllData(datestr: ref.getDateString())
        do{
            sleep(1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateAllData(datestr: ref.getDateString())
        do{
            sleep(1)
        }
    }
    
    func updateAllData(datestr: String){
        var funds = self.ref.getTotalFunds(date: datestr) ?? 1
        var spendings = self.ref.getTotalSpendings(date: datestr) ?? 1
        var saved = 100
        if (spendings != 0){
            saved = (100 - Int((funds-spendings)/funds))
        }
        self.totalSaved.text = (funds-spendings).description
        self.percentSaved.text = "\(saved.description)%"
        self.topCostsData = self.ref.getOrderedSpendingRate(date: datestr) ?? ["No data": 0]
        self.initTopCostsChart()
        self.updateTopCostsChartData()
    }
    
    func initTopCostsChart() {
        self.topCostsPieChart.legend.verticalAlignment = .center
        self.topCostsPieChart.legend.horizontalAlignment = .right
        self.topCostsPieChart.legend.orientation = .vertical
        self.topCostsPieChart.drawEntryLabelsEnabled = false
        self.topCostsEntries = []
        self.topCostsData.forEach { (key: String, value: Int) in
            topCostsEntries.append(PieChartDataEntry(value: Double(value), label: key))
        }
    }
    
    func updateTotalCostsView(chane: DataChange) {
        self.changeIcon.image = chane.icon
        self.changeIcon.setImageColor(color: chane.color!)
        self.percentSaved.textColor = chane.color
    }
    
    func getChange(changeValue: Int) -> DataChange {
        if changeValue == 0 {
            return flat
        }
        else if changeValue > 0 {
            return up
        }
        else {
            return down
        }
    }
    
    func updateTopCostsChartData() {
        let chartDataSet = PieChartDataSet(entries: self.topCostsEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueTextColor(UIColor.black)
        chartDataSet.colors = chartColors
        topCostsPieChart.data = chartData
    }

}
