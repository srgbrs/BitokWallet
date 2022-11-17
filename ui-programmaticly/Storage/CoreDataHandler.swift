
import Foundation

class CoreDataHandler {
    public static let context = AppDelegate.persistentContainer.viewContext
    
     func createTransaction(amount: Int, date: String, dateString: String, type: String, category: String){
        
         // Create an object
         let newTransaction = Transaction(context: CoreDataHandler.context)
         newTransaction.amount = Int32(amount)
         newTransaction.category = category
         newTransaction.date = Date.init()
         newTransaction.dateString = dateString
         newTransaction.type = type
         
             try!  CoreDataHandler.context.save()
         
    }
    
    static func getAlltransactions() -> [Transaction] {
        var array = try! CoreDataHandler.context.fetch(Transaction.fetchRequest())
        array = array.reversed()
        return array
        
    }
    
    static func deleteAllTransactions() {
        
    }
}
