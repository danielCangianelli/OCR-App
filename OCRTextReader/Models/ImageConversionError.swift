import Foundation

enum ImageConversionError: LocalizedError {
    case invalidData
    case invalidImage
    case failedToLoad(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Os dados da imagem não são válidos."
        case .invalidImage:
            return "Não foi possível criar uma imagem a partir dos dados fornecidos."
        case .failedToLoad(let error):
            return "Erro ao carregar a imagem: \(error.localizedDescription)"
        }
    }
}
