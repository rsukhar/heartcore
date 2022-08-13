//
//  AuthView.swift
//  TestSUIApp
//
//  Created by Влад Мади on 12.08.2022.
//

import SwiftUI

struct AuthView: View {
    
    @State private var text = "bitter record jeans network again remain solve manage liar three glue mixed"
    @State private var showMainView = false
    
    var body: some View {
        VStack {
            Text("Import from seed phrase:")
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(radius: 1)
                    .frame(height: 300)
                if text.isEmpty {
                    Text("Enter space-separated seed phrase words...")
                        .padding(6)
                        .foregroundColor(.gray)
                }
                
            }
            Button {
                Task {
                    await InMemoryAccountStorage.shared.restoreAccount(phrase: text)
                    showMainView.toggle()
                }
            } label: {
                Text("Import")
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .cornerRadius(12)
            }
            Spacer()
        }.padding()
            .fullScreenCover(isPresented: $showMainView) {
                MainView()
            }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
