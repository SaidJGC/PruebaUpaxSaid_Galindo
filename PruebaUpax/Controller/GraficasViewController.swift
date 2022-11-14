//
//  GraficasViewController.swift
//  ChartsTutorial
//
//  Created by user229147 on 11/12/22.
//  Copyright © 2022 iOSTemplates. All rights reserved.
//

import UIKit
import Charts


class GraficasViewController: UIViewController {
    
    var lista =  [Datum]()

    @IBOutlet weak var nombre1: UILabel!
    
    @IBOutlet weak var grafica01: PieChartView!
    
    @IBOutlet weak var nombre2: UILabel!
    
    @IBOutlet weak var grafica02: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDatosGrafica1()
        loadDatosGrafica2()
        // Do any additional setup after loading the view.
    }
    
    func loadDatosGrafica1(){
        
        DispatchQueue.main.async {
            
            let getpreguntas = { [self] (listapreguntas : [Datum])  in
                self.lista = listapreguntas
                let valor1 = lista[0].values[0].value
                let valor2 = lista[0].values[1].value
                let valores = [valor1, valor2]
                let text1 = lista[0].values[0].label
                let text2 = lista[0].values[1].label
                let texts = [text1, text2]
                customizeChart(dataPoints: texts, values: valores)
                nombre1.text = lista[0].pregunta
                
            }

            ListaApi.getApi(onCompletition: getpreguntas)

               }
    }
    
    
    func loadDatosGrafica2(){
        
        DispatchQueue.main.async {
            
            let getpreguntas = { [self] (listapreguntas : [Datum])  in
                self.lista = listapreguntas
                let valor1 = lista[1].values[0].value
                let valor2 = lista[1].values[1].value
                let valor3 = lista[1].values[2].value
                let valor4 = lista[1].values[3].value
                let valor5 = lista[1].values[4].value
                let valor6 = lista[1].values[5].value
                let valores = [valor1, valor2, valor3, valor4, valor5, valor6]
                let text1 = lista[1].values[0].label
                let text2 = lista[1].values[1].label
                let text3 = lista[1].values[2].label
                let text4 = lista[1].values[3].label
                let text5 = lista[1].values[4].label
                let text6 = lista[1].values[5].label
                let texts = [text1, text2, text3, text4, text5, text6]
                customizeChart02(dataPoints: texts, values: valores)
                nombre2.text = lista[1].pregunta
                
            }

            ListaApi.getApi(onCompletition: getpreguntas)

               }
    }
    
    
    func customizeChart(dataPoints: [String], values: [Int]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      grafica01.data = pieChartData
    }
    
    func customizeChart02(dataPoints: [String], values: [Int]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      grafica02.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
        
    }
}
