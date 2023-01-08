//
//  ContentView.swift
//  BitcoinMenuBar
//
//  Created by Jake Quinter on 1/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var bitcoin: Crypto?
    
    var body: some View {
        VStack {
            Text(bitcoin?.formattedAmount ?? "0")
        }
        .padding()
        .onAppear(perform: loadData)
    }
    
    func fetchStrikeAPI() async throws {
        guard let url = URL(string: "https://api.strike.me/v1/rates/ticker") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(Keys.STRIKE_API_KEY)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([Crypto].self, from: data)
        
        bitcoin = result.first(where: { $0.sourceCurrency == "BTC"})
    }
    
    func loadData() {
        Task {
            do {
                try await fetchStrikeAPI()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
