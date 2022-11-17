import Foundation
import UIKit

class IncomeViewModel : NSObject  {
    let networkServices = NetworkServices()
    
    var btcRate = Dynamic("")
    var btcAmount = Dynamic("")
    
    let context = AppDelegate.persistentContainer.viewContext
    
    //var transactionsStorage : [Transa] = []
    var transactionsStorage : [Transaction] = []

    
    func updateBtcRate() {
        
        networkServices.networkQuery.decodeAPI(completionHandler: { (rate) in
            self.btcRate.value = "1$ = \(String(rate)) BTC"
            
        })
    }
    
    @objc func updateBtcAmount() {
        btcAmount.value = "\(UserDefaults.standard.integer(forKey: "wallet")) BITCOINS "
    }
    
    func fetchTransactionsFromStorage(){
        do {
            self.transactionsStorage =  CoreDataHandler.getAlltransactions()
            DispatchQueue.main.async {
                // update Table view!
                
            }
        } catch {
            
        }
    }
    
   
    
    init(test: Dynamic<String> = Dynamic(""), btcRate: Dynamic<String> = Dynamic(""), btcAmount: Dynamic<String> = Dynamic("")) {
        super.init()
        self.btcRate = btcRate
        self.btcAmount = btcAmount
        
        self.updateBtcRate()
        self.updateBtcAmount()
        
        self.fetchTransactionsFromStorage()
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector:#selector(updateBtcAmount), name: Notification.Name("updateBtcAmount"), object: nil)
        
  
    }
    
}


extension IncomeViewModel : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.id) as! TransactionsTableViewCell
        cell.backgroundColor = .clear
        
        
        let transaction = transactionsStorage[indexPath.row]
        
        cell.amountLabel.text = String(transaction.amount)
        cell.dateLabel.text = transaction.dateString
        cell.categoryLabel.text = transaction.category
        
        cell.categoryLabel.text = transactionsStorage[indexPath.row].category
        
        if transaction.type == "expense" {
            cell.categoryLabel.textColor = UIColor(named: "DeepRed")
            
        } else if  (transaction.type == "profit"){
            cell.categoryLabel.textColor = UIColor(named: "CalmGreen")
        }
        
        return cell
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 1
       }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return transactionsStorage.count
       }

}
