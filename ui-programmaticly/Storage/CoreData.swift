import Foundation
import UIKit
import CoreData

open class CoreDataManager: NSObject {
    
    public static let sharedInstance = CoreDataManager()
    
    private override init() {}
    
    private lazy var userEntity: NSEntityDescription = {
        let managedContext = getContext()
        return NSEntityDescription.entity(forEntityName: "User", in: managedContext!)!
    }()


    private func getContext() -> NSManagedObjectContext? {
        return AppDelegate.persistentContainer.viewContext
    }

    func retrieveUser() -> NSManagedObject? {
        guard let managedContext = getContext() else {
            print("getContext error")
            return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if result.count > 0 {
                return result[0]
            } else {
                print("result count = 0 ")
                return nil
            }
        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
           return nil
        }
    }
    

    func saveTransaction(_ transaction: TransactionModel) {
        print(NSStringFromClass(type(of: transaction)))
        guard let managedContext = getContext() else {
            print("managedContext error")
            return }
        guard let user = retrieveUser() else {
            print("retrieveUser error")
            return }
        
        var transactions: [TransactionModel] = []
        if let pastBooks = user.value(forKey: "transactions") as? [TransactionModel] {
            transactions += pastBooks
        }
        transactions.append(transaction)
        user.setValue(transactions, forKey: "transactions")
        print("sucess")
        
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
    }

}
