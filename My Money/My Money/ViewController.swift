//
//  ViewController.swift
//  My Money
//
//  Created by Никита Крупей on 3/25/19.
//  Copyright © 2019 Никита Крупей. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var totalMoneyForMonth: UILabel!
    
    var monthMoney = ""
     var myCurrentSalary = [SalaryInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<SalaryInformation> = SalaryInformation.fetchRequest()
        do {
            let salary = try PersistenceService.context.fetch(fetchRequest)
            self.myCurrentSalary = salary
            //self.view.reloadData()
            self.totalMoneyForMonth.reloadInputViews()
        } catch {}
        
        
        
        startButton.layer.cornerRadius = 15
        totalMoneyForMonth.text = "\(MoneyForCurrentMonth()) грн"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func MoneyForCurrentMonth() -> Int {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "dd.MM.yyyy"
        var totalMoney = 0
        let nowDate = Date()
        
        let ThisDateComponents = calendar.dateComponents([.year, .month, .day], from: nowDate)
        
        for item in myCurrentSalary{
            let checkDate = formatter.date(from: item.date!)!
            let checkDateComponents = calendar.dateComponents([.year, .month, .day], from: checkDate)
            
            if ThisDateComponents.year == checkDateComponents.year && ThisDateComponents.month == checkDateComponents.month {
                totalMoney = totalMoney + Int(item.moneyEarned)
            }
        }
        
        return totalMoney
    }
    
    
    
    
    @IBAction func startSegue(segue: UIStoryboardSegue) {
        
    }


}

