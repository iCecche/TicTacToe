//
//  File.swift
//  TicTacToe
//
//  Created by amministratore on 06/04/2021.
//

import Foundation
// dichiarazione tipo Sign
enum Sign {
    case cross,circle,none
//    creo variabile che a seconda di Sign restitusice string diversa
    var identity : String {
        switch self {
        case .cross:
            return "X"
        case .circle:
            return "O"
        case .none:
            return ""
      }
    }
}
//struttura di funzionamento del gioco
struct GameFlow {
// array di array che corrisponde a tabella contenenti tipi Sign
    var array : [[Sign]] = [[.none,.none,.none],[.none,.none,.none],[.none,.none,.none]]
    
// controllo che l'indirizzo array sia non vuoto per recuperare valore di tipo sign contenuto altrimento -> .none ("")
    func getValue(indexI : Int, indexJ : Int) -> Sign {
        if array[indexI][indexJ] != .none  {
            return array[indexI][indexJ]
        }else{
            return .none
        }
    }
// setto valore di tipo sign passato come param (.cross,.circle,.none) in indice array passato come param
   mutating func setValue(_ state : Sign, for indexI : Int, for indexJ : Int)  {
            array[indexI][indexJ] = state
       }
//  controllo possibili abbinamneti per vittoria e verifico che almeno il primo non sia .none ("") se primo non vuoto per sillogismo
//  (confronto a tre) tutti pieni
    func isWin() -> Bool {
        
        if (array[0][0] == array[0][1] && array[0][1] == array[0][2] && array[0][0] != .none) ||
             (array[1][0] == array[1][1] && array[1][1] == array[1][2] && array[1][0] != .none) ||
               (array[2][0] == array[2][1] && array[2][1] == array[2][2] && array[2][0] != .none) {
            return true
        }else if (array[0][0] == array[1][0] && array[1][0] == array[2][0] && array[0][0] != .none) ||
                   (array[0][1] == array[1][1] && array[1][1] == array[2][1] && array[0][1] != .none) ||
                     (array[0][2] == array[1][2] && array[1][2] == array[2][2] && array[0][2] != .none) {
            return true
        }else if (array[0][0] == array[1][1] && array[1][1] == array[2][2] && array[0][0] != .none) ||
                   (array[0][2] == array[1][1] && array[1][1] == array[2][0] && array[0][2] != .none) {
            return true
        }
        return false
   }
    
// inizializzo array per new game
  mutating func restart() {
    var i : Int = 0
    while i < 3 {
      var j : Int = 0
        while j < 3 {
            array[i][j] = .none
            j += 1
        }
        i += 1
    }
  }
}
