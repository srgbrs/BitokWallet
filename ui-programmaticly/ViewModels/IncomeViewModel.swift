

import Foundation
import UIKit

class IncomeViewModel : NSObject {
    let networkServices = NetworkServices()
    
    var btcRate = Dynamic("")
    var btcAmount = Dynamic("")
    

    func updateBtcRate() {
        
        networkServices.networkQuery.decodeAPI(completionHandler: { (rate) in
            self.btcRate.value = "1$ = \(String(rate)) BTC"
            
        })
    }
    
    func updateBtcAmount() {
        btcAmount.value = "\(UserDefaults.standard.integer(forKey: "wallet")) BITCOINS "
    }
    
    init(test: Dynamic<String> = Dynamic(""), btcRate: Dynamic<String> = Dynamic(""), btcAmount: Dynamic<String> = Dynamic("")) {
        super.init()
        self.btcRate = btcRate
        self.btcAmount = btcAmount
        
        self.updateBtcRate()
        self.updateBtcAmount()
    }
    
}


extension IncomeViewModel : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.id) as! TransactionsTableViewCell
        cell.backgroundColor = .clear
        
        
        let transactions = UserDefaultsManager.get()
        let transaction = transactions![indexPath.row]
        cell.amountLabel.text = String(transaction.amount)
        cell.dateLabel.text = transaction.dateString
        cell.categoryLabel.text = transaction.category
        
        if transaction.transactionType == "expense" {
            cell.categoryLabel.textColor = UIColor(named: "DeepRed")
            
        } else if  (transaction.transactionType == "profit"){
            cell.categoryLabel.textColor = UIColor(named: "CalmGreen")
        }
        
        return cell
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 1
       }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return UserDefaultsManager.get()?.count ?? 0
       }

}
