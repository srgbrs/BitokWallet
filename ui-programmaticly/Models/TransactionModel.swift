
import Foundation
import CoreData


public class TransactionModel : NSObject {
    
    
    var amount : Int = 0
    var date = Date()
    var dateString = ""
//    var transactionType: TransactionType = .profit
//    var category: TransactionCategory = .uncategorized
    var transactionType : String = ""
    var category : String
    
    required convenience public init(from decoder: Decoder) throws {
        try self.init(from: decoder)
      }
    
    init(amount: Int, date: Date = Date.init(), category: String, transactionType: String ) {

        self.amount = amount
        self.date = date
        self.transactionType = transactionType
        //self.category = category
        self.dateString = date.toString()
        self.category = category
    }
    
//    static var T = TransactionModel(amount: 2, c , transactionType: TransactionType.profit.toString())
    
}
enum TransactionType: String, CaseIterable {
    case expense = "expense"
    case profit = "profit"
    
    func toString() -> String {
        let string = ""
        switch self {
        case .expense:
            return "expense"
        case .profit:
            return "profit"
        }
    }
    
    static func get(from: String) -> TransactionType {
        if from == expense.rawValue {
            return .expense }
        else
        {
            return .profit
        }
       
    }
}

enum TransactionCategory: String, CaseIterable {
    case restaraunts = "restaraunts"
    case traveling = "traveling"
    case uncategorized = "uncategorized"
    case other = "other"
    
    func toString() -> String {
        let string = ""
        switch self {
        case .restaraunts:
            return "restaraunts"
        case .other:
            return "other"
        case .traveling:
            return "traveling"
        case .uncategorized:
            return "uncategorized"
        }
    }
    
    static func get(from: String) -> TransactionCategory {
            if from == restaraunts.rawValue {
                return .restaraunts
            } else if from == other.rawValue {
                return .other
            } else if from == traveling.rawValue {
                return .traveling
            }
            return .uncategorized
        }
}

public struct TransactionModelUD : Codable {
    var amount : Int
    var date : String
    var dateString : String
    var transactionType: String
    var category: String
    
    init(amount: Int, date: String, dateString: String, transactionType: String, category: String) {
        self.amount = amount
        self.date = date
        self.dateString = dateString
        self.transactionType = transactionType
        self.category = category
    }
}

//class Transaction : Codable {
//    enum CodingKeys: String, CodingKey, Equatable {
//            case amount
//            case dateString
//            case category
//            case type
//            case date
//        }
//
//    @NSManaged var amount : Int
//    @NSManaged var dateString : String
//    @NSManaged var category: String
//    @NSManaged var type: String
//    @NSManaged var date : Date
//
//    init(amount: Int, dateString : String, category: String, type: String, date: Date = Date.init() ) {
//        self.amount = amount
//        self.dateString = date.toString()
//        self.category = category
//        self.type = type
//        self.date = Date.init()
//    }
//
//}
