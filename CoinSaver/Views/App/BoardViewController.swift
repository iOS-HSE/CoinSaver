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

let up = DataChange(icon: UIImage(named: "arrow_up"), color: MaterialPalette.materialGreenDarker)
let down = DataChange(icon: UIImage(named: "arrow_down"), color: MaterialPalette.materialRed)
let flat = DataChange(icon: UIImage(named: "dash"), color: MaterialPalette.materialYellow)


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
        MaterialPalette.materialRed,
        MaterialPalette.materialYellow,
        MaterialPalette.materialGreen
    ]
    
    var topCostsEntries = [PieChartDataEntry]()
    let ref = FDatabase.getInstance()
    
    @IBAction func selectDate(_ sender: UIButton) {
        let sb = UIStoryboard(name: "DatePickerPopupStoryboard", bundle: nil)
        let popup = sb.instantiateInitialViewController() as! DatePickerPopup
        present(popup, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalCostsView.initCircleView()
        
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
        
        if BasicUserSettings.isDarkMode {
            themeService.switch(.dark)
        } else {
            themeService.switch(.light)
        }
        
        sleep(2)
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, yyyy"
        
        self.dateLabel.text = formatter.string(from: date)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateAllData(datestr: ref.getDateString())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateAllData(datestr: ref.getDateString())
    }
    
    func updateAllData(datestr: String){
        let funds = self.ref.getTotalFunds(date: datestr)
        let spendings = self.ref.getTotalSpendings(date: datestr)
        let saved = spendings == 0 ? 100 : 100 - (Float(spendings) / Float(funds) * 100)
        print(saved)
        self.totalSaved.text = (funds - spendings).description
        self.percentSaved.text = "\(String(format: "%.2f", saved))%"
        self.topCostsData = self.ref.getOrderedSpendingRate(date: datestr)
        self.initTopCostsChart()
        self.updateTopCostsChartData()
        self.updateTotalCostsView(change: getChange(changeValue: saved))
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
        self.topCostsPieChart.data?.notifyDataChanged()
        self.topCostsPieChart.notifyDataSetChanged()
    }
    
    func updateTotalCostsView(change: DataChange) {
        self.changeIcon.image = change.icon
        self.changeIcon.setImageColor(color: change.color!)
        self.percentSaved.textColor = change.color
    }
    
    func getChange(changeValue: Float) -> DataChange {
        if changeValue == 50 {
            return flat
        }
        else if changeValue > 50 {
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
