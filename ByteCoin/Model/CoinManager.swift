//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Kelvin Ricafort on 8/7/23.
//

import Foundation

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9D8D22F0-27F1-4F7A-BAC1-E7A06D604737"
    
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            print(error)
            return nil
        }
    }
}
