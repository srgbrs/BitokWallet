
import Foundation
import CoreData

class TransactionsArray  {
    var transactions: [TransactionModel] = []
}

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
    
    static var T = TransactionModel(amount: 2, category: TransactionCategory.restaraunts.toString(), transactionType: TransactionType.profit.toString())
    
}
enum TransactionType: CaseIterable {
    case expense
    case profit
    
    func toString() -> String {
        let string = ""
        switch self {
        case .expense:
            return "expense"
        case .profit:
            return "profit"
        }
    }
}

enum TransactionCategory: CaseIterable {
    case restaraunts
    case traveling
    case uncategorized
    case other
    
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
