//
//  PhotoPicker.swift
//  UsedGames
//
//  Created by MacBook Pro on 30.09.2023.
//

import UIKit
import SwiftUI

struct PhotoPicker : UIViewControllerRepresentable {
    
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedPhoto: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext <PhotoPicker>) -> some UIViewController {
         
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var photoPicker: PhotoPicker
        
         init( _ picker: PhotoPicker) {
            self.photoPicker = picker
             super.init()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedPhoto =
                info[.editedImage] as? UIImage
                ?? info[.originalImage] as? UIImage {
                photoPicker.selectedPhoto = selectedPhoto
                
                UIImageWriteToSavedPhotosAlbum(selectedPhoto, self, #selector(image(_:error:contextInfo:)) , nil)
            } else {
                photoPicker.selectedPhoto = nil

            }
            picker.dismiss(animated: true, completion: nil )
            
        }
        @objc func image(_ image: UIImage?, error: Error?, contextInfo:UnsafeRawPointer){
            
            
        }

    }
    
}
