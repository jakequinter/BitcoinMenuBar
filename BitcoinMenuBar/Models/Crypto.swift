//
//  Crypto.swift
//  BitcoinMenuBar
//
//  Created by Jake Quinter on 1/8/23.
//

import Foundation

struct Crypto: Decodable, Identifiable {
    let amount: String
    let sourceCurrency: String
    let targetCurrency: String
    
    var id: String { sourceCurrency }
    var formattedAmount: String {
        guard let total = Double(amount) else { return "0" }
        return total.formatted(.currency(code: "USD"))
    }
}
