import Foundation

enum OCRError: Error, LocalizedError {
    case emptyImage
    case visionRequestFailed
    case cgImageConversionFailed
    case textRecognitionFailed
    case noTextFound
    
    var errorDescription: String? {
        switch self {
        case .emptyImage:
            return "Imagem fornecida está vazia."
        case .visionRequestFailed:
            return "Falha ao realizar a requisição de OCR."
        case .cgImageConversionFailed:
            return "Não foi possível converter a imagem."
        case .textRecognitionFailed:
            return "Falha ao reconhecer o texto na imagem."
        case .noTextFound:
            return "Nenhum texto encontrado na imagem."
        }
    }
}
