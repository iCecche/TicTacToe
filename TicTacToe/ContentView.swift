//
//  ContentView.swift
//  TicTacToe versione 1.0 (multiplayer locale)
//
//  Created by amministratore on 06/04/2021.
//
// tabella creata da spacing di VStack e HStack con sfondo colorato

import SwiftUI
//colore base tabella (in realtà colore sfondo VStack)
var linearStart = LinearGradient(gradient: .init(colors: [.red,.green,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
var tableElement : Int = 0


struct ContentView: View {
// var State che si refreshano ad ogni modifica
    @State var viewModel = GameFlow() //var che rende @State la struct Gameflow
    @State var player : Player = .one //var type Player che switcha tra .one e .two
    @State var textWin : String = "" //label testo vittoria
    @State var buttonEnable : Bool = true //disabilita pulsante dopo fine partita
    @State var oneWin : Int = 0 //vittorie X
    @State var twoWin : Int = 0 //vittorie O
    
    var body: some View {
       ZStack{
        VStack(alignment: .center, spacing :0){
            HStack{
                if tableElement == 0 {
                    Text("Tic Tac Toe").font(.system(size: 35))
                        .frame(width: 200, height: 75, alignment: .center)
                        .padding(.top,50)
                        .padding(.bottom,70)
                        
                }else{
                    Text("Player X : \(oneWin)").font(.system(size: 30))
                        .frame(width: 180, height: 75, alignment: .center)
                        .padding(.top,50)
                        .padding(.bottom,70)
                        .padding(.leading,15)
                        
                    Text("Player O : \(twoWin)").font(.system(size: 30))
                        .frame(width: 180, height: 75, alignment: .center)
                        .padding(.top,50)
                        .padding(.bottom,70)
                        .padding(.trailing,10)
                        
                }
        }
        VStack(alignment: .center, spacing: 1)
        {
            ForEach(0...2, id: \.self) {i in
            HStack(alignment: .center, spacing: 1)
            {
                ForEach(0...2, id : \.self) {j in
                    Button(action: {self.buttonPressed(indexI: i, indexJ: j)}, label: {
                        Text(GetValue(indexI: i, indexJ: j)).font(Font.custom("Serif", size: 40))
                            .frame(width: 70, height: 70, alignment: .center)
                            .padding()
                            .foregroundColor(Color("DarkColor"))
                            .background(Color("AccentColor"))
                    })
                }
            }
          }
        }.background(linearStart)
        VStack(alignment: .center)
        {
            if viewModel.isWin() || tableElement == 9
           {
                Text(textWin).font(.system(size: 30))
                   .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                   .padding(.top,26)
                Button(action: {restart()}, label: {
                   Text("New Game").font(.system(size: 30))
                    .foregroundColor(.blue)
                    .padding(.top)
                })
           }else{
               Text(textWin).font(.system(size: 30))
                   .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                   .padding(.top,10)
                   .hidden()
               Button(action: {}, label: {
                 Text("New Game").font(.system(size: 30))
                   .padding()
                   .hidden()
            })
           }
        }
       }
      }
 }
// action dei pulsanti
    func buttonPressed(indexI : Int, indexJ : Int) {
// se turno player .one, se casella è vuota , e se partita non finita
        if player == .one && viewModel.array[indexI][indexJ] == .none && buttonEnable
        {
// setto valore : richiamo funzione della struct
            viewModel.setValue(.cross, for: indexI, for: indexJ)
            tableElement += 1
// se condizione di win
            if !viewModel.isWin() && tableElement == 9
            {
                textWin = "It's a draw X/O!"
            }else if viewModel.isWin()
            {
// player vincente è il valore del player attuale
                oneWin += 1
                if oneWin == 3
                {
                    textWin = "Player \(player.rawValue) won the game!"
                }else
                {
                    textWin = "Player \(player.rawValue) won!"
                }
                buttonEnable = false
            }
            player.toggle()
// stessa cosa ma per player .two
        }else if player == .two && viewModel.array[indexI][indexJ] == .none && buttonEnable
        {
            viewModel.setValue(.circle, for: indexI, for: indexJ)
            tableElement += 1
            
            if !viewModel.isWin() &&  tableElement == 9
            {
                textWin = "It's a draw X/O!"
            }else if viewModel.isWin()
            {
                twoWin += 1
                if twoWin == 3 {
                    textWin = "Player \(player.rawValue) won the game!"
                }else{
                    textWin = "Player \(player.rawValue) won!"
                }
                buttonEnable = false
            }
            player.toggle()
        }
    }
// restituisce il text della label pulsanti
    func GetValue(indexI : Int, indexJ : Int) -> String {
// invocazione func della struct, restituisce valore var identity di Sign
        return viewModel.getValue(indexI : indexI, indexJ: indexJ).identity
    }
// resatta impostazioni iniziali per new game
    func restart(){
        textWin = ""
        buttonEnable = true
        viewModel.restart() // richiamo func della struct
        player = .one
        tableElement = 0
        if oneWin == 3 || twoWin == 3 {
            oneWin = 0
            twoWin = 0
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


