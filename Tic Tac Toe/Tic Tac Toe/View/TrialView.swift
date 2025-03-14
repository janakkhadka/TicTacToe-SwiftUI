//import SwiftUI
//
//struct MainMenuView: View {
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Tic-Tac-Toe")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                
//                // Navigate to 2-Player Mode
//                NavigationLink("Play with Computer") {
//                    TwoPlayerModeView()
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                // Navigate to Computer Mode
//                NavigationLink("Play with Friend") {
//                    ComputerModeView()
//                }
//                .buttonStyle(CustomButtonStyle())
//            }
//            .padding()
//        }
//    }
//}
//
//// 🎮 Two Player Mode View
//struct TwoPlayerModeView: View {
//    var body: some View {
//        VStack {
//            Text("2-Player Mode")
//                .font(.title)
//            
//            // Game UI Goes Here...
//            
//            NavigationLink("Back to Menu") {
//                MainMenuView()
//            }
//            .buttonStyle(CustomButtonStyle())
//        }
//    }
//}
//
//// 🤖 Computer Mode View
//struct ComputerModeView: View {
//    var body: some View {
//        VStack {
//            Text("Computer Mode")
//                .font(.title)
//            
//            // AI Game Logic Goes Here...
//
//            NavigationLink("Back to Menu") {
//                MainMenuView()
//            }
//            .buttonStyle(CustomButtonStyle())
//        }
//    }
//}
//
//// 🔘 Custom Button Style
//struct CustomButtonStyles: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .frame(width: 200)
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
//            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
//    }
//}
//
//#Preview {
//    MainMenuView()
//}
