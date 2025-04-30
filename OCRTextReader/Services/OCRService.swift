import VisionKit
import Vision

protocol OCRServiceProtocol {
    func recognizeText(from images: [UIImage]) async throws -> String
}

class OCRService: OCRServiceProtocol {
    func recognizeText(from images: [UIImage]) async throws -> String {
        try await withThrowingTaskGroup(of: String.self) { group in
            for image in images {
                group.addTask {
                    try await self.processImage(image)
                }
            }
            
            let fullText = try await group.reduce(into: "") { result, text in
                result += text + "\n\n"
            }
            
            return fullText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private func processImage(_ image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else {
            throw OCRError.cgImageConversionFailed
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = makeTextRecognitionRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(throwing: OCRError.textRecognitionFailed)
                    return
                }
                
                let text = observations.compactMap {
                    $0.topCandidates(1).first?.string
                }.joined(separator: "\n")
                
                if text.isEmpty {
                    continuation.resume(throwing: OCRError.noTextFound)
                } else {
                    continuation.resume(returning: text)
                }
            }
            
            do {
                try VNImageRequestHandler(cgImage: cgImage).perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func makeTextRecognitionRequest(completion: @escaping VNRequestCompletionHandler) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest(completionHandler: completion)
        request.recognitionLanguages = ["pt-BR"]
        request.recognitionLevel = .accurate
        return request
    }
}
