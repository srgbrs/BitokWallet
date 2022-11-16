
import Foundation


class UserDefaultsManager {
    static func set(array: [TransactionModelUD]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "TransactionsUD")
        }
    }
    
    static func get() -> [TransactionModelUD]? {
        if let saved = UserDefaults.standard.object(forKey: "TransactionsUD") as? Data {
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode([TransactionModelUD].self, from: saved) {
                return loaded
            }
        }
        return nil
    }
    
    static func add(value: TransactionModelUD) {
        
        if (self.get() == nil) {
            var array : [TransactionModelUD] = []
            array.append(value)
            self.set(array: array)
        } else {
            var array = self.get()
            array?.append(value)
            self.set(array: array!)

        }
        
    }
}
