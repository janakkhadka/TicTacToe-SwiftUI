//
//  FirstView.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 18/02/2025.
//

import SwiftUI

struct FirstView: View {
    @State private var username: String = ""                      // To store user input
    @State private var isLoggedIn: Bool = false                   // Track login status
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("JK Tic-Tac-Toe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if isLoggedIn {
                    Text("Welcome, \(username)!")
                        .font(.largeTitle)
                        .padding()
                }

                NavigationLink("Computer") {
                    WithComputerView()
                }
                .buttonStyle(CustomButtonStyle())

                NavigationLink("2-Player(OFFlINE)") {
                    WithPlayerView()
                }
                .buttonStyle(CustomButtonStyle())
                
                NavigationLink("2-Player(ONLINE)") {
                    WithOnlinePlayerView()
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
            .onAppear {
                if !isLoggedIn {
                    showAlert = true
                }
            }
            .alert("Enter your name", isPresented: $showAlert){
                TextField("Name", text: $username)
                Button("Cancel", role: .cancel) {}
                Button("Save"){
                    save()
                }
            }
            
        }
    }
    func save(){
        print("save")
    }
}


#Preview {
    FirstView()
}
