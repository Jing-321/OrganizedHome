//
//  ImagePicker.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/1/21.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
}
