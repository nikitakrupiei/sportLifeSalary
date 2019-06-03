//
//  DetailedViewController.swift
//  My Money
//
//  Created by Никита Крупей on 3/25/19.
//  Copyright © 2019 Никита Крупей. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var HoursWorkedThatDay: UILabel!
    @IBOutlet weak var MoneyEarnedThatDay: UILabel!
    @IBOutlet weak var MoneyEarnedTillDay: UILabel!
    

    var date = ""
    var hours = ""
    var moneyThat = ""
    var moneyTill = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Date.text = date
        HoursWorkedThatDay.text = "\(hours) часов"
        MoneyEarnedThatDay.text = "\(moneyThat) грн"
        MoneyEarnedTillDay.text = "\(moneyTill) грн"
        //UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9152866006, green: 0.246553123, blue: 0.2010768652, alpha: 1)
       
       // UINavigationBar.appearance().isTranslucent = false
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
