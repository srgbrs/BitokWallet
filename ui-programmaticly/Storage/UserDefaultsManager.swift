import Foundation


class UserDefaultsManager {
    
    static func updateWallet(amount: Int) {
        var wallet = UserDefaults.standard.integer(forKey: "wallet")
        wallet += amount
        UserDefaults.standard.set(wallet, forKey: "wallet")
    }
    
    static func getWallet() -> (int: Int, string: String) {
        let wallet = UserDefaults.standard.integer(forKey: "wallet")
        return (wallet, String(wallet))
    }
}
