//
//  TableViewController.swift
//  My Money
//
//  Created by Никита Крупей on 3/25/19.
//  Copyright © 2019 Никита Крупей. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var names = ["Loh", "Koh", "Soh"]
    var myCurrentSalary = [SalaryInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.9152866006, green: 0.246553123, blue: 0.2010768652, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
        
        
        let fetchRequest: NSFetchRequest<SalaryInformation> = SalaryInformation.fetchRequest()
        do {
            let salary = try PersistenceService.context.fetch(fetchRequest)
            //let salary = try PersistanceService.context.fetch(fetchRequest)
            self.myCurrentSalary = salary
            
            let size = myCurrentSalary.count
            
            let formatter = DateFormatter()
            let calendar = Calendar.current
            formatter.dateFormat = "dd.MM.yyyy"
            
            for i in 0..<size {
                var pass = (size - 1) - i
                
                
                for j in 0..<pass {
                    var key = formatter.date(from: myCurrentSalary[j].date!)!
                        //myCurrentSalary[j].date
                    
                    if key < formatter.date(from: myCurrentSalary[j+1].date!)! {
                        let temp = myCurrentSalary[j+1]
                        myCurrentSalary[j+1] = myCurrentSalary[j]
                        myCurrentSalary[j] = temp
                        
                    }
                }
//                let thisDate = formatter.date(from: item.date!)!
//                let nextDate = formatter.date(from: (item.).da
//
//
//                let checkDateComponents = calendar.dateComponents([.year, .month, .day], from: thisDate)
//
//                if ThisDateComponents.year == checkDateComponents.year && ThisDateComponents.month == checkDateComponents.month && checkDateComponents.day! <= ThisDateComponents.day! {
//                    money = money + Int(item.moneyEarned)
               // }
                
            }
            //self.tableView.reloadData()
            self.table.reloadData()
        } catch {}
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCurrentSalary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
         //let moneyEarned = names[indexPath.row]
        // let sl = salary[indexPath.row].date
        
        //cell!.textLabel!.text = names[indexPath.row]
       cell!.textLabel!.text = myCurrentSalary[indexPath.row].date
        
        cell?.textLabel?.textColor = #colorLiteral(red: 0.9152866006, green: 0.246553123, blue: 0.2010768652, alpha: 1)
        cell?.backgroundColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1)
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedSegue"{
            if let indexPath = table.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailedViewController
                destinationController.date = myCurrentSalary[indexPath.row].date!
                destinationController.hours = String(myCurrentSalary[indexPath.row].hoursWorked)
                destinationController.moneyThat = String(myCurrentSalary[indexPath.row].moneyEarned)
                destinationController.moneyTill = String(MoneyTillTheDaySelected(myCurrentSalary[indexPath.row].date!))
            }
        }
        
        if segue.identifier == "totalMonthSegue"{
            
                let destinationController = segue.destination as! ViewController
                destinationController.monthMoney = String(MoneyForCurrentMonth())
            
        }
        
        
        
        
    }
    
    @IBAction func UnwindToHours(segue: UIStoryboardSegue) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            PersistenceService.context.delete(self.myCurrentSalary[indexPath.row])
           // PersistanceService.context.delete(self.myCurrentSalary[indexPath.row])
            PersistenceService.saveContext()
            //PersistanceService.saveContext()
            self.table.reloadData()
            
        }
    }
    
    func MoneyTillTheDaySelected(_ selectedDay: String) -> Int{
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "dd.MM.yyyy"
        //date.text = formatter.string(from: datePicker.date)
        let thisDate = formatter.date(from: selectedDay)!
        var money = 0
        let ThisDateComponents = calendar.dateComponents([.year, .month, .day], from: thisDate)
        
        for item in myCurrentSalary {

            let thisDate = formatter.date(from: item.date!)!
            let checkDateComponents = calendar.dateComponents([.year, .month, .day], from: thisDate)
            
            
            if ThisDateComponents.year == checkDateComponents.year && ThisDateComponents.month == checkDateComponents.month && checkDateComponents.day! <= ThisDateComponents.day! {
                money = money + Int(item.moneyEarned)
            }
        }
        
        return money
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
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let destinationController = segue.destination as! DetailedViewController
////            destinationController.information = (CloudCabmin[indexPath.row].object(forKey: "Information") as? String)!
////            destinationController.videoURL = (CloudCabmin[indexPath.row].object(forKey: "videoURL") as? String)!
//            destinationController.date = names[indexPath.row]
//            destinationController.hours = names[indexPath.row]
//            destinationController.moneyThat = names[indexPath.row]
//            destinationController.moneyTill = names[indexPath.row]
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
