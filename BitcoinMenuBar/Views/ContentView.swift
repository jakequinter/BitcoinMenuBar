//
//  ContentView.swift
//  BitcoinMenuBar
//
//  Created by Jake Quinter on 1/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var bitcoin: Crypto?
    @State private var isFetching = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if isFetching {
                ProgressView()
                    .scaleEffect(0.5)
                
            } else {
                HStack {
                    Text("BTC")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        isFetching = true
                        Task {
                            await fetchStrikeAPI()
                            isFetching = false
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.secondary)
                    
                    Button {
                        quit()
                    } label: {
                        Image(systemName: "x.circle.fill")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.secondary)
                }
                .padding(.bottom, 4)
                .multilineTextAlignment(.center)
                
                Text(bitcoin?.formattedAmount ?? "0")
                    .font(.title)
            }
        }
        .padding()
        .frame(width: 150)
        .onAppear {
            Task {
                await fetchStrikeAPI()
            }
        }
    }
    
    func fetchStrikeAPI() async {
        do {
            guard let url = URL(string: "https://api.strike.me/v1/rates/ticker") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(Keys.STRIKE_API_KEY)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode([Crypto].self, from: data)
            
            bitcoin = result.first(where: { $0.sourceCurrency == "BTC"})
        } catch {
            print("Strike API call failed.")
            print(error.localizedDescription)
        }
    }
    
    func quit() {
        NSApp.terminate(nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

