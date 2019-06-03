//
//  AddHoursTableViewController.swift
//  My Money
//
//  Created by Никита Крупей on 3/25/19.
//  Copyright © 2019 Никита Крупей. All rights reserved.
//

import UIKit
import CoreData

class AddHoursTableViewController: UITableViewController {

    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var hours: UITextField!
    
    let datePicker = UIDatePicker()
    
    var temporarySalary = [SalaryInformation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        hours.keyboardType = .numberPad
        date.inputView = datePicker
        datePicker.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        doneButton.tintColor = UIColor.black
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        // date.inputAccessoryView = toolbar
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let monthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        
        datePicker.minimumDate = monthAgo
        datePicker.maximumDate = monthLater
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)

    }
    
    
    @objc func doneAction(){
        //getDateFromPicker()
        view.endEditing(true)
    }
    @objc func dateChanged(){
        getDateFromPicker()
    }
    @objc func tapGestureDone(){
        view.endEditing(true)
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        date.text = formatter.string(from: datePicker.date)
    }

    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let pickedDate = date.text
        let pickedHours = hours.text
        
        if pickedDate == "" || pickedHours == "" {
            let alertController = UIAlertController(title: "Не пошло чёт", message: "Введи все значения", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Пробуем ещё", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil) //тут менял
            
            return
        }
        // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let salary = SalaryInformation(context: PersistenceService.context)
        
        
        //        let formatter = DateFormatter()
        //        formatter.dateFormat = "dd.MM.yyyy"
        //date.text = formatter.string(from: datePicker.date)
        //salary.date = formatter.date(from: pickedDate!)! as NSData
        salary.date = pickedDate
        salary.hoursWorked = Int64(pickedHours!)!
        salary.moneyEarned = Int64(pickedHours!)! * 44
       // PersistanceService.saveContext()
        PersistenceService.saveContext()
        
        self.temporarySalary.append(salary)
        
        performSegue(withIdentifier: "finishedSaving", sender: self)
        // let salary = SalaryInfo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishedSaving"{
            
            let navVC = segue.destination as? UINavigationController
            
            let tableVC = navVC?.viewControllers.first as! TableViewController
            
            tableVC.myCurrentSalary = temporarySalary
        //var vc = segue.destination as! TableViewController
            //vc.myCurrentSalary = temporarySalary
        }
    }
    

}
