//
//  GameLogicsVM.swift
//  Slot Machine
//
//  Created by Content Arcade on 18/05/2023.
//

import Foundation
import SwiftUI

class GameLogicVM: ObservableObject {
    
    let gameItems = [ sevenImg,
                      strawberryImg,
                      grapeImg,
                      cherryImg,
                      coinImg,
                      bellImg
                    ]
    
    @Published var selectedItem1 = sevenImg
    @Published var selectedItem2 = grapeImg
    @Published var selectedItem3 = cherryImg
    //Score
    @Published var availableCoins = 100
    @Published var highScore      = 0
    // betCoins
    @Published var betCoins = 10
    // Popups and Alerts
    @Published var showRefillAlert = false
    @Published var showInfoView    = false
    
    
    func playGame() {
        selectedItem1 = ""
        selectedItem2 = ""
        selectedItem3 = ""
        playSound(sound: spin)
        withAnimation(Animation.easeInOut(duration: 0.5)) { [self] in
            selectedItem1 = gameItems.randomElement() ?? coinImg
            selectedItem2 = gameItems.randomElement() ?? cherryImg
            selectedItem3 = gameItems.randomElement() ?? grapeImg
            self.checkGameStatus()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
//            self.checkGameStatus()
//        }
    }
    
    func checkGameStatus() {
        if selectedItem1 == selectedItem2 && selectedItem1 == selectedItem3 {
            // wining state
            gameWon()
        } else {
            //looding state
            gameLossed()
        }
    }
    
    func gameWon() {
        let newScore = betCoins * 10
        if highScore < newScore {
            highScore = newScore
            availableCoins = newScore
            playSound(sound: newHighScore)
        } else{
            availableCoins = newScore
            playSound(sound: win)
        }
    }
    
    func gameLossed() {
        if betCoins == 10 {
            if availableCoins >= 20 {
                availableCoins -= 10
            } else {
                playSound(sound: outOfCoins)
                showRefillAlert = true
            }
            
        } else if betCoins == 20 {
            if availableCoins >= 40 {
                availableCoins -= 20
            } else {
                playSound(sound: outOfCoins)
                showRefillAlert = true
            }
            
        }
    }
   
    func changeBetCoins(_ coins: Int) {
        if betCoins != coins {
            playSound(sound: betCoinsChange)
            betCoins = coins
        }
    }
    
    func resetGame() {
        playSound(sound: resetGameSound)
        showRefillAlert = false
        availableCoins = 100
    }
}
