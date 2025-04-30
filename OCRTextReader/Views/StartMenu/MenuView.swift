import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                MenuButton(title: "Iniciar OCR") {
                    OCRView()
                }
                .accessibilityLabel("Botão para iniciar o reconhecimento de texto")
                .accessibilityAddTraits(.isButton)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("OCR App")
        }
    }
}

struct MenuButton<Destination: View>: View {
    var title: String
    @ViewBuilder let destination: () -> Destination
    
    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: destination()) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .buttonStyle(PressableButtonStyle()) 
    }
}

#Preview {
    MenuView()
}
