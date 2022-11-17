import Foundation
import UIKit

class SpendingsViewModel : NSObject {
    let networkServices =  NetworkServices()
    
    var btcRate = Dynamic("")
    
    var selectedCategory = Dynamic(0)
    var textFieldText = Dynamic("")
    var bitcoinsAmount = Dynamic(0)
    
    override init() {
        super.init()

    }
    
    func updateBtcRate() {
        
        networkServices.networkQuery.decodeAPI(completionHandler: { (rate) in
            self.btcRate.value = "1$ = \(String(rate)) BTC"
            
        })
    }
    
    func updateBitcoinsAmount() {
        // self.bitcoinsAmount.value = UserDefaultsManager.
    }

}

// MARK: - PickerView Delegate
extension SpendingsViewModel: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TransactionCategory.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory.value = pickerView.selectedRow(inComponent: 0)

    }
    
       func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
           var label = UILabel()
           if let v = view {
               label = v as! UILabel
           }
           label.font = UIFont(name: "BRCobane-Medium", size: 20.0)
           label.textColor = UIColor(named: "DarkBlue")

           label.text = TransactionCategory.allCases[row].toString()
           label.textAlignment = .center
           return label
       }
       
    
}

// MARK: - TextView Delegate
extension SpendingsViewModel : UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.hasText {
            self.textFieldText.value = textField.text!
        }
    }
}
