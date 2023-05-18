//
//  RefillView.swift
//  Slot Machine
//
//  Created by Content Arcade on 18/05/2023.
//

import SwiftUI

struct RefillView: View {
    
    @State var gameVM = GameLogicVM()
    @State var animate = false
    
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
            
            Spacer()
            
            VStack(spacing: fullHeight * 0.03) {
                Image("gfx-seven-reel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: fullHeight * 0.14,
                           height: fullHeight * 0.13)
                    .scaleEffect(animate ? 1:0.8)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                
                Text("Bad luck! You lost all of the coins. \nLet's play again!")
                    .font(.system(size: fullHeight * 0.02,
                                  design: .rounded))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.gray)
                
                Button(action: {
                    gameVM.resetGame()
                }) {
                  Text("New Game".uppercased())
                    .font(.system(size: fullHeight * 0.016,
                                  design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.pink)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(width: fullHeight * 0.13,
                           height: fullHeight * 0.04)
                    .background(
                      Capsule()
                        .strokeBorder(lineWidth: 1.75)
                        .foregroundColor(.pink)
                    )
                }
            }
            .frame(maxHeight: fullHeight * 0.4)
            Spacer()
        }
        .frame(maxWidth: fullHeight * 0.35,
               maxHeight: fullHeight * 0.4, alignment: .top)
        .background(Color.white)
        .foregroundColor(.white)
        .cornerRadius(14)
        .onAppear() {
            animate.toggle()
        }
    }
}

struct RefillView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RefillView()
                .previewDevice(
                PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            RefillView()
                .previewDevice(
                PreviewDevice(rawValue: "iPhone 14 Pro"))
        }
    }
}
