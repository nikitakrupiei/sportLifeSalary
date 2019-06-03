//
//  SalaryInformation+CoreDataProperties.swift
//  My Money
//
//  Created by Никита Крупей on 3/25/19.
//  Copyright © 2019 Никита Крупей. All rights reserved.
//
//

import Foundation
import CoreData


extension SalaryInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalaryInformation> {
        return NSFetchRequest<SalaryInformation>(entityName: "SalaryInformation")
    }

    @NSManaged public var moneyEarned: Int64
    @NSManaged public var hoursWorked: Int64
    @NSManaged public var date: String?

}
