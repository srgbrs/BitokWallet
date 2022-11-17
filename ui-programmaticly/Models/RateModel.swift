import Foundation

struct RateModel : Codable {
    public struct time: Codable {
        let updated : String
        let updatedISO : String
        let updateduk: String
    }

    let time: time
    let bpi: bpi
    let disclaimer: String
    let chartName: String

    struct bpi : Codable {
        let USD, GBP, EUR: Currency
    }
    
    // MARK: - Currency
    struct Currency : Codable {
        let code, symbol, rate, description: String
        let rate_float: Double
    }

}
