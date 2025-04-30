import SwiftUI

struct ScanMenuView: View {
    let onScanTapped: () -> Void
    let onPhotoLibraryTapped: () -> Void

    var body: some View {
        Menu {
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onScanTapped()
            }) {
                Label("Escanear com Câmera", systemImage: "camera")
            }

            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onPhotoLibraryTapped()
            }) {
                Label("Escolher da Galeria", systemImage: "photo.on.rectangle")
            }
        } label: {
            Label("Selecionar Imagens", systemImage: "camera.viewfinder")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
