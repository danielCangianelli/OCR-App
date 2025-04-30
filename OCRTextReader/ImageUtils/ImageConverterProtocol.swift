import SwiftUI
import PhotosUI

protocol ImageConverterProtocol {
    func convert(items: [PhotosPickerItem]) async throws -> [UIImage]
}

struct ImageConverter: ImageConverterProtocol {
    func convert(items: [PhotosPickerItem]) async throws -> [UIImage] {
        try await withThrowingTaskGroup(of: UIImage.self) { group in
            for item in items {
                group.addTask {
                    do {
                        guard let data = try await item.loadTransferable(type: Data.self) else {
                            throw ImageConversionError.invalidData
                        }
                        guard let image = UIImage(data: data) else {
                            throw ImageConversionError.invalidImage
                        }
                        return image.prepareForOCR()
                    } catch {
                        print("Erro ao carregar imagem: \(error)")
                        throw ImageConversionError.failedToLoad(error)
                    }
                }
            }

            var images: [UIImage] = []
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
}

extension UIImage {
    func prepareForOCR() -> UIImage {
        return self
            .fixOrientation()
            .resized(to: CGSize(width: 1200, height: 1600))
    }

    func resized(to targetSize: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    func fixOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
