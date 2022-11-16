
import Foundation
import UIKit

class SpendingsViewModel : NSObject {
    let networkServices =  NetworkServices()
    
    var btcRate = Dynamic("")
    
    var selectedCategory = Dynamic(0)
    var textFieldText = Dynamic("")
    
    override init() {
        super.init()

    }
    
    // have caegory and amount
    func addTransactionButtonPressed() {
        
    }
    
    func updateBtcRate() {
        
        networkServices.networkQuery.decodeAPI(completionHandler: { (rate) in
            self.btcRate.value = "1$ = \(String(rate)) BTC"
            
        })
    }

}

extension SpendingsViewModel: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TransactionCategory.allCases.count
    }
    

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
           return TransactionCategory.allCases[row].toString()
       }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory.value = pickerView.selectedRow(inComponent: 0)

    }
    
}
