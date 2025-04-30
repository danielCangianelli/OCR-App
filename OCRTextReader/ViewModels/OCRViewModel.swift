import SwiftUI
import PhotosUI

@MainActor
class OCRViewModel: ObservableObject {
    @Published var scannedText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let ocrService: OCRServiceProtocol
    private let converter: ImageConverterProtocol
    
    init(
        ocrService: OCRServiceProtocol = OCRService(),
        converter: ImageConverterProtocol = ImageConverter()
    ) {
        self.ocrService = ocrService
        self.converter = converter
    }
    
  
    private func handleError(_ error: Error) {
        if let ocrError = error as? OCRError {
            setError(error, context: "Ocorreu um erro no OCR")
         } else {
             setError(error, context: "Erro inesperado")
         }
    }
    
    private func setError(_ error: Error, context: String) {
        errorMessage = """
        \(context):
        \(error.localizedDescription)
        """
    }
}

extension OCRViewModel {
    func processPhotos(_ items: [PhotosPickerItem]) async {
        isLoading = true
        errorMessage = nil

        do {
            let images = try await converter.convert(items: items)
            await processScannedImages(images)
        } catch {
            handleError(error)
            isLoading = false
        }
    }

    func processScannedImages(_ images: [UIImage]) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await ocrService.recognizeText(from: images)
            scannedText = result
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }
    
}
