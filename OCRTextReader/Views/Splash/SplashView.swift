import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Image(systemName: "doc.text.viewfinder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
        }
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            MenuView()
        }
    }
}
