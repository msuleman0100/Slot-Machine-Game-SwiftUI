//
//  ContentView.swift
//  Slot Machine
//
//  Created by Content Arcade on 17/05/2023.
//

import SwiftUI

let images = [sevenImg, cherryImg, grapeImg]
struct ContentView: View {
    
    @StateObject var gameVM = GameLogicVM()
    var slideInAnimation: Animation {
      Animation.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)
        .speed(1)
        .delay(0.25)
    }
    @State var animate = false
    
    var body: some View {
        ZStack {
            Image("gfx-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay( Color.black.opacity(gameVM.showRefillAlert ? 0.6:0) )
            GeometryReader { geo in
                VStack(spacing: 10) {
                    
                    //MARK: Top Buttons And Logo
                    HStack(alignment: .top) {
                        Button(action: {withAnimation{ gameVM.resetGame() } }, label: {
                            Image(systemName: "repeat.1.circle.hi")
                                .font(.system(size: fullHeight * 0.035))
                        })
                        Spacer()
                        
                        Image(slotMachinLogoImg)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: fullHeight * 0.47, maxHeight: fullHeight * 0.20)
                            .scaleEffect(animate ? 1:0.8)
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                        
                        Spacer()
                        
                        Button(action: { gameVM.showInfoView.toggle() }, label: {
                            Image(systemName: "info.circle")
                                .font(.system(size: fullHeight * 0.035))
                        })
                    }
                    .padding([.top, .leading, .trailing])
                
                    Spacer()
                    //MARK: Available Coins and Score
                    HStack {
                        
                        HStack {
                            Text("**Your\nCouns**")
                                .font(.system(size: fullHeight * 0.015))
                                .lineSpacing(0)
                            Text("**\(gameVM.availableCoins)**")
                                .font(.system(size: fullHeight * 0.037))
                                .fontDesign(.monospaced)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 18)
                        .frame(minWidth: 128)
                        .background(Color.purple)
                        .cornerRadius(100)
                        
                        Spacer()
                        
                        HStack {
                            Text("**\(gameVM.highScore)**")
                                .font(.system(size: fullHeight * 0.037))
                                .fontDesign(.monospaced)
                            Text("**High\nScore**")
                                .font(.system(size: fullHeight * 0.015))
                                .lineSpacing(0)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 18)
                        .frame(minWidth: 128)
                        .background(Color.purple)
                        .cornerRadius(100)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    //MARK: Game Options And Play Button
                    VStack {
                        HStack {
                            Spacer()
                            GameOptionView(imageName: gameVM.selectedItem1)
                                
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            GameOptionView(imageName: gameVM.selectedItem2)
                            Spacer()
                            GameOptionView(imageName: gameVM.selectedItem3)
                            Spacer()
                        }
                        //Play Button
                        HStack {
                            Spacer()
                            Button(action: { gameVM.playGame() }, label: {
                                GameOptionView(imageName: spinBtnImage)
                                
                            })
                            
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    //MARK: Bet Changing Buttons
                    HStack(alignment: .center, spacing: 10) {
                        Text("**20**")
                            .font(.system(size: geo.size.width * 0.06))
                            .frame(width: geo.size.width * 0.15, height: geo.size.width * 0.09)
                            .background(gameVM.betCoins == 10 ? .purple:.pink)
                            .cornerRadius(100)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) { gameVM.changeBetCoins(20) }
                            }
                        
                        if gameVM.betCoins == 10 { Spacer() }
                        Image(betCoinsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                        if gameVM.betCoins == 20 { Spacer() }
                        
                        Text("**10**")
                            .font(.system(size: geo.size.width * 0.06))
                            .frame(width: geo.size.width * 0.15, height: geo.size.width * 0.09)
                            .background(gameVM.betCoins == 20 ? .purple:.pink)
                            .cornerRadius(100)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration:0.5)) { gameVM.changeBetCoins(10) }
                            }
                    }
                    .padding(.horizontal)
                    
                }
                .foregroundColor(.white)
            }
            .frame(maxWidth:fullWidth, maxHeight:fullHeight, alignment:.bottom)
            .overlay( Color.black.opacity(gameVM.showRefillAlert ? 0.6:0) )
            
            if gameVM.showRefillAlert {
                RefillView(gameVM: gameVM)
            }
            
        }
        .task {
            DispatchQueue.main.async {
                playSound(sound: firstOpening)
                animate.toggle()
            }
        }
        .sheet(isPresented: $gameVM.showInfoView) {
            InfoView()
        }
    }
}

//extension ContentView {
//    @ViewBuilder func gameOptionsAndPlayBtn() -> some View {
//        VStack {
//            HStack {
//                Spacer()
//                GameOptionView(imageName: gameVM.selectedItem1)
//                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.35)
//                Spacer()
//            }
//            HStack {
//                Spacer()
//                GameOptionView(imageName: gameVM.selectedItem2)
//                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.35)
//                Spacer()
//                GameOptionView(imageName: gameVM.selectedItem3)
//                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.35)
//                Spacer()
//            }
//            //Play Button
//            HStack {
//                Spacer()
//                GameOptionView(imageName: spinBtnImage)
//                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.35)
//                    .onTapGesture {
//                        gameVM.playGame()
//                    }
//                Spacer()
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(
                PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            ContentView()
                .previewDevice(
                PreviewDevice(rawValue: "iPhone 14 Pro"))
        }
    }
}


struct GameOptionView: View {
    var imageName: String = sevenImg
    var body: some View {
        ZStack {
            Image(gameOptionBgImg)
                .resizable()
                .scaledToFit()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding(0)
                .scaleEffect(imageName.isEmpty ? 0:1)
                .animation(Animation.easeInOut(duration: 0.3), value: imageName.isEmpty)
        }
        .frame(width: fullHeight * 0.17, height: fullHeight * 0.17)
    }
}

