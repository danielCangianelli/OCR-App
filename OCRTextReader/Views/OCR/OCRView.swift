import SwiftUI
import PhotosUI

struct OCRView: View {
    @StateObject private var viewModel = OCRViewModel()
    @State private var showScanner = false
    @State private var showPhotoLibrary = false
    @State private var selectedPhotos: [PhotosPickerItem] = []
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                ScannedResultView(
                    text: viewModel.scannedText,
                    onClear: {
                        viewModel.scannedText = ""
                        selectedPhotos.removeAll()
                    }
                )
                
                ScanMenuView(
                    onScanTapped: { showScanner = true },
                    onPhotoLibraryTapped: { showPhotoLibrary = true }
                )
            }
            .padding()
            .navigationTitle("OCR")
            .sheet(isPresented: $showScanner) {
                DocumentScannerView { images in
                    Task { await viewModel.processScannedImages(images) }
                }
            }
            .photosPicker(
                isPresented: $showPhotoLibrary,
                selection: $selectedPhotos,
                matching: .images
            )
            
            if viewModel.isLoading {
                LoadingOverlayView()
            }
        }
        .alert("Erro", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .onChange(of: selectedPhotos) {
            Task {
                await viewModel.processPhotos(selectedPhotos)
            }
        }
    }
}


#Preview {
    OCRView()
}
