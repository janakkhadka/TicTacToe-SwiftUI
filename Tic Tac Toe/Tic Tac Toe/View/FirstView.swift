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
    
    @State private var isUsernameSaved: Bool = UserDefaults.standard.bool(forKey: "isloggedin")
    @State private var savedUsername: String = UserDefaults.standard.string(forKey: "username") ?? "" //?? le chai nil xa vane blank string dinxa, ! yo use garda chai tya value xa nai vanera assume garxa
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("JK Tic-Tac-Toe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                

                Text("Welcome, \(savedUsername)!")
                    .font(.largeTitle)
                    .padding()
                    .opacity(isUsernameSaved ? 1 : 0)


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
                if !isUsernameSaved {
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
        isLoggedIn = true
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(isLoggedIn, forKey: "isloggedin")
    }
}


#Preview {
    FirstView()
}
