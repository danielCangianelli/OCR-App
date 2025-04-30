import SwiftUI

struct ScannedResultView: View {
    let text: String
    let onClear: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView {
                Text(text.isEmpty ? "Nenhum texto escaneado ainda." : text)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(minHeight: 150, maxHeight: 300)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)

            if !text.isEmpty {
                Button("Limpar") {
                    onClear()
                }
                .foregroundColor(.red)
                .accessibilityLabel("Limpar texto escaneado")
            }
        }
    }
}
