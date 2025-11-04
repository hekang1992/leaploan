//
//  Untitled.swift
//  leaploan
//
//  Created by hekang on 2025/11/2.
//

import UIKit
import Photos

/// ALBUM_PICKER_MANAGER
class AlbumPickerManager: NSObject {
    
    static let shared = AlbumPickerManager()
    private var completion: ((UIImage?) -> Void)?
    
    func pickImage(from viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    self.presentImagePicker(from: viewController)
                case .denied, .restricted:
                    self.showPermissionAlert(from: viewController, type: "相册")
                case .notDetermined:
                    break
                default:
                    self.completion?(nil)
                }
            }
        }
    }
    
    private func presentImagePicker(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        viewController.present(imagePicker, animated: true)
    }
    
    private func showPermissionAlert(from viewController: UIViewController, type: String) {
        let alert = UIAlertController(
            title: "权限被拒绝",
            message: "请前往设置允许应用访问\(type)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        viewController.present(alert, animated: true)
    }
    
    private func compressImage(_ image: UIImage) -> UIImage? {
        return ImageCompressor.compressImage(image, toMaxKB: 500)
    }
}

extension AlbumPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            let compressedImage = compressImage(image)
            completion?(compressedImage)
        } else {
            completion?(nil)
        }
        
        completion = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
        completion = nil
    }
}


/// CAMERA_PICKER_MANAGER
class CameraPickerManager: NSObject {
    
    static let shared = CameraPickerManager()
    private var completion: ((UIImage?) -> Void)?
    
    func takePhoto(from viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.presentCamera(from: viewController)
                } else {
                    self.showPermissionAlert(from: viewController, type: "相机")
                }
            }
        }
    }
    
    private func presentCamera(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(
                title: "相机不可用",
                message: "当前设备没有可用的相机",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "确定", style: .default))
            viewController.present(alert, animated: true)
            completion?(nil)
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.cameraCaptureMode = .photo
        viewController.present(imagePicker, animated: true)
    }
    
    private func showPermissionAlert(from viewController: UIViewController, type: String) {
        let alert = UIAlertController(
            title: "权限被拒绝",
            message: "请前往设置允许应用访问\(type)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        viewController.present(alert, animated: true)
    }
    
    private func compressImage(_ image: UIImage) -> UIImage? {
        return ImageCompressor.compressImage(image, toMaxKB: 500)
    }
}

extension CameraPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            let compressedImage = compressImage(image)
            completion?(compressedImage)
        } else {
            completion?(nil)
        }
        
        completion = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
        completion = nil
    }
}


class ImageCompressor {
    
    static func compressImage(_ image: UIImage, toMaxKB maxKB: Int) -> UIImage? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        if imageData.count <= maxKB * 1024 {
            return image
        }
        
        var compression: CGFloat = 0.9
        let maxCompression: CGFloat = 0.1
        let minFileSize = maxKB * 1024
        
        var compressedData = imageData
        
        while compressedData.count > minFileSize && compression > maxCompression {
            if let data = image.jpegData(compressionQuality: compression) {
                compressedData = data
            }
            compression -= 0.1
        }
        
        if compressedData.count > minFileSize {
            return resizeImage(image, toMaxKB: maxKB)
        }
        
        return UIImage(data: compressedData)
    }
    
    private static func resizeImage(_ image: UIImage, toMaxKB maxKB: Int) -> UIImage? {
        var currentImage = image
        var imageData = currentImage.jpegData(compressionQuality: 0.7)
        let minFileSize = maxKB * 1024
        
        while let data = imageData, data.count > minFileSize && currentImage.size.width > 500 {
            let scale: CGFloat = 0.8
            let newSize = CGSize(
                width: currentImage.size.width * scale,
                height: currentImage.size.height * scale
            )
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, currentImage.scale)
            currentImage.draw(in: CGRect(origin: .zero, size: newSize))
            currentImage = UIGraphicsGetImageFromCurrentImageContext() ?? currentImage
            UIGraphicsEndImageContext()
            
            imageData = currentImage.jpegData(compressionQuality: 0.7)
        }
        
        return currentImage
    }
}
