import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2)
            .padding()
            .background(.thinMaterial)
            .cornerRadius(20)
            .accessibilityLabel("Carregando")
    }
}
