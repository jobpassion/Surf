//
//  BarChartsView.swift
//  Surf
//
//  Created by yarshure on 14/02/2018.
//  Copyright © 2018 A.BIG.T. All rights reserved.
//

import UIKit
import Charts
import SFSocket
import XRuler
class BarChartsView: UIView,ChartViewDelegate {

    @IBOutlet  var chartView:BarChartView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.backgroundColor = UIColor.gray
    }
    func setup(){
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
        
        
        
        
    }
    override func awakeFromNib(){
        setup()
        setup2()
    }
    func setup2(){
        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        //xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = ""
        leftAxisFormatter.positiveSuffix = ""
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 4
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 4
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        
//        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
//                                  font: .systemFont(ofSize: 12),
//                                  textColor: .white,
//                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
//                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
//        marker.chartView = chartView
//        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker
//        
//        sliderX.value = 12
//        sliderY.value = 50
//        slidersValueChanged(nil)
    }
    func updateFlow(_ flow:NetFlow) {
        let  data = flow.totalFlows
        if data.count < 60 {
            var fill = Array<SFTraffic>.init(repeating: SFTraffic.init(), count: 60-data.count)
            fill.append(contentsOf: data)
            self.update(fill)
        }else {
            self.update(data)
        }
        
    }
    func update(_ data:[SFTraffic]){
        
        //var yVals1:[BarChartDataEntry] = []
        var index :Double = 0
        
        var unit = "KB/s"
        var sbq:Double = 1.0
        let rate = 1.2
        let maxRx =  data.max(by: { $0.rx < $1.rx})
        let maxTx =  data.max(by: { $0.tx < $1.tx})
        let max = Int(maxRx!.rx)
        if max < 1024{
            unit =  "B/s"
            sbq = 1
        }else if max >= 1024 && max < 1024*1024 {
            sbq = 1024.0
            unit =  "KB/s"
        }else if max >= 1024*1024 && max < 1024*1024*1024 {
            //return label + "\(x/1024/1024) MB" + s
            unit = "MB/s"
            sbq = 1024.0*1024.0
        }else {
            //return label + "\(x/1024/1024/1024) GB" + s
            unit =  "GB/s"
            sbq = 1024.0*1024.0*1024
        }
            
            
            
            
            
        
        
        
//        for i in data {
//            let yy:Double = i / sbq
//
//            let y = BarChartDataEntry(x: index, yValues: [yy, -yy])//BarChartDataEntry.init(x: index, y: yy)
//            yVals1.append(y)
//            index += 1
//        }
        let yVals1 =  data.map { dd -> BarChartDataEntry in
            let entry =   BarChartDataEntry(x: index, yValues: [Double(dd.rx)/sbq, -(Double(dd.tx)/sbq)])
            index += 1
            return entry
        }
        var set1:BarChartDataSet
        if let cc = chartView {
            
            let  leftAxis:YAxis = cc.leftAxis;
            leftAxis.labelTextColor = UIColor.cyan
            
            leftAxis.axisMaximum  = Double(maxRx!.rx) * rate/sbq
            leftAxis.axisMinimum =  -Double(maxTx!.tx) * rate/sbq
            
            if let d = cc.data {
                if d.dataSetCount > 0 {
                    set1 = d.dataSets[0] as! BarChartDataSet
                    set1.values = yVals1
                    //set1.label = unit
                    set1.stackLabels = [unit, unit]
                    cc.data!.notifyDataChanged()
                    cc.notifyDataSetChanged()
                }
            }else {
                
                
                set1 = BarChartDataSet.init(values: yVals1, label: "")
                set1.stackLabels = [unit, unit]
                set1.colors = [UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1),
                               UIColor(red: 23/255, green: 197/255, blue: 255/255, alpha: 1)
                ]
                set1.axisDependency = .left;
                //set1.drawFilledEnabled = true
                //set1.mode = .cubicBezier
                set1.drawValuesEnabled = false
                //set1.setColor(UIColor.red)
//                set1.setCircleColor(UIColor.white)
//                set1.lineWidth = 2.0;
//                set1.circleRadius = 3.0;
//                set1.fillAlpha = 65/255.0;
//                set1.drawCirclesEnabled = false
//                set1.fillColor = UIColor.brown
                set1.highlightColor = UIColor.yellow
        //        set1.drawCircleHoleEnabled = false;
                
               // let ids:[IChartDataSet] = [set1]
              //  let ldata:BarChartData = BarChartData(dataSets: set1)
              //  ldata.setValueTextColor(UIColor.white)
              //  ldata.setValueFont(UIFont.systemFont(ofSize: 9.0))
                let data = BarChartData(dataSet: set1)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.9
                cc.data = data
            }
        }
    }
}
