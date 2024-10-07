import Foundation

struct CoinData: Codable {
    let rate: Double
}

struct CoinModel {
    let rate: Double
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
