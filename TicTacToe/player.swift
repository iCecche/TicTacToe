//
//  player.swift
//  TicTacToe
//
//  Created by amministratore on 07/04/2021.
//

import Foundation
// dichiarazione tipo dato Player
enum Player : String {
    case one = "X"
    case two = "O"
}
// estensione di dichiarazione player
extension Player {
// funzione che alterna turno player .one e player .two
  mutating func toggle() {
        if self == .one {
            self = .two
        }else {
            self = .one
        }
    }
}
