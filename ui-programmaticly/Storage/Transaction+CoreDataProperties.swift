//
//  Transaction+CoreDataProperties.swift
//  ui-programmaticly
//
//  Created by Sergey Borisov on 17.11.2022.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var dateString: String?
    @NSManaged public var category: String?
    @NSManaged public var type: String?
    @NSManaged public var date: Date?

}

extension Transaction : Identifiable {

}
