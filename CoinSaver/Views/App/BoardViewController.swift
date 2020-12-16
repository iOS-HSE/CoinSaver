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
    
    @IBOutlet weak var topCostsPieChart: PieChartView!
    
    var topCost1 = PieChartDataEntry(value: 0)
    var topCost2 = PieChartDataEntry(value: 0)
    var topCost3 = PieChartDataEntry(value: 0)
    
    var topCostsData = [
        "tc1": 15,
        "tc2": 25,
        "tc3": 60
    ]
    
    let chartColors = [
        UIColor.red,
        UIColor.yellow,
        UIColor.green
    ]
    
    var topCostsEntries = [PieChartDataEntry]()
    
    @IBAction func selectDate(_ sender: UIButton) {
        let sb = UIStoryboard(name: "DatePickerPopupStoryboard", bundle: nil)
        let popup = sb.instantiateInitialViewController() as! DatePickerPopup
        present(popup, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Board"
        
        self.initTopCostsChart()
        self.totalCostsView.initCircleView()
        
        NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) {
            (notification) in
            
            let datePickerPopup = notification.object as! DatePickerPopup
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.dateLabel.text = formatter.string(from: datePickerPopup.datePicker.date)
            
        }
        
        updateTopCostsChartData()
        
        updateTotalCostsView(chane: getChange(changeValue: 2))
    }
    
    func initTopCostsChart() {
        self.topCostsPieChart.legend.verticalAlignment = .center
        self.topCostsPieChart.legend.horizontalAlignment = .right
        self.topCostsPieChart.legend.orientation = .vertical
        self.topCostsPieChart.drawEntryLabelsEnabled = false
        
        self.topCostsEntries = [
            topCost1,
            topCost2,
            topCost3
        ]
        
        for (entry, data) in zip(topCostsEntries, topCostsData) {
            entry.label = data.key
            entry.value = Double(data.value)
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
