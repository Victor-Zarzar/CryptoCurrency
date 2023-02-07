//
//  ContentView-Model.swift
//  BitCoin
//
//  Created by Victor Zarzar on 07/02/23.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 100
        
        var filteredRates: [Rate] {
            return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
            
        }
        
        func refreshData() {
            CryptoAPI().getCryptoData(currency: "EUR", previewMode: true) { newRates in
                DispatchQueue.main.async {
                    withAnimation {
                        self.rates = newRates
                    }
                    print("Sucessfully got new rates: \(self.rates.count)")
                }
            }
            
        }
    
        func calcRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
    }
    
}


