//
//  ContentView.swift
//  TestSUIApp
//
//  Created by Влад Мади on 12.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var solBalance: Double = 0.0
    @State var usdcBalance: Double = 0.0
    
    @State var sourceValue: Double? = nil
    @State var toValue: Double? = nil
    
    @State var isFromSol = true
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {

            
            Text("From:")
            ZStack(alignment: .trailing) {
                TextField("amount...", value: $sourceValue, format: .number)
                    .padding()
                    .background(.white)
                    .shadow(radius: 1)
                
                Text(isFromSol ? "SOL" : "USDC")
                    .padding()
            }
            HStack {
                Text("To (estimated):")
                Spacer()
                Button {
                    isFromSol.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }.padding(.trailing)

            }
            ZStack(alignment: .trailing) {
                TextField("amount...", value: $toValue, format: .number)
                    .padding()
                    .background(.white)
                    .shadow(radius: 1)
                Text(isFromSol ? "USDC" : "SOL")
                    .padding()
                
            }
            
            Button {
                
            } label: {
                Text("Trade")
            }.frame(maxWidth: .infinity)
                .padding()
                .background(.orange)
                .foregroundColor(.black)

            
        }
        
        .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading)  {
                    Text("Balance:")
                    Text("\(solBalance) SOL")
                    Text("\(usdcBalance) USDC")
                }.padding()
            }
            .onAppear {
                Task {
                    let balance = try! await RPCClient().getBalance()
                    self.solBalance = balance
                    
                    do {
                        let usdc = try await RPCClient().getUSDC()
                        print(usdc)
                        self.usdcBalance = usdc
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
