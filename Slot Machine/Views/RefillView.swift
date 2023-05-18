//
//  RefillView.swift
//  Slot Machine
//
//  Created by Content Arcade on 18/05/2023.
//

import SwiftUI

struct RefillView: View {
    
    @State var gameVM = GameLogicVM()
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                Text("Game Over")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                Spacer()
            }
            .frame(maxWidth: fullWidth-48, maxHeight: 70, alignment: .center)
            .background(Color.purple)
            
            VStack(spacing: 20) {
                Image("gfx-seven-reel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .background(.black)
                Text("Bad luck! You lost all of the coins. \nLet's play again!")
                  .font(.system(.body, design: .rounded))
                  .lineLimit(2)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.gray)
         
                Button(action: {
                    gameVM.resetGame()
                }) {
                  Text("New Game".uppercased())
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.pink)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(minWidth: 134)
                    .background(
                      Capsule()
                        .strokeBorder(lineWidth: 1.75)
                        .foregroundColor(.pink)
                    )
                }
            }
            .frame(maxHeight: 280)
           
        }
        .frame(maxWidth: fullWidth-48, maxHeight: 350)
        .background(Color.white)
        .foregroundColor(.white)
        .cornerRadius(14)
    }
}

struct RefillView_Previews: PreviewProvider {
    static var previews: some View {
        RefillView()
    }
}
