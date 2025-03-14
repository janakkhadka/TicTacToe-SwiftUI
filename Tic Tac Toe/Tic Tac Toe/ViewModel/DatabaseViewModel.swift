//
//  ViewModel.swift
//  Tic Tac Toe
//
//  Created by Janak Khadka on 14/03/2025.
//

import Foundation
import FirebaseDatabase

class DatabaseViewModel: ObservableObject {
    let dbRef = Database.database(url: "https://tic-tac-toe-f606f-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    @Published var board = GameBoard()
    
    
    
    
}
