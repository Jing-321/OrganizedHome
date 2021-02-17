//
//  EditAreaView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/8/21.
//

import SwiftUI

struct EditAreaView: View {
    var hideSheetCallback: () -> Void
    @State var area: Area
    @State private var name: String
    @State private var selectedAreaIndex = 0
    @State var parent: Area?
    @State private var showAlert = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentCamera = false
    @State private var isShowPhotoLibrary = false
    @State var newImage: UIImage?
    private var displayImage: Image {
        get {newImage == nil ? area.img : Image(uiImage: self.newImage!)}
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                DisplayImageView(image: displayImage, scale: 1)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: $newImage, isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Pick a picture from..."), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            }
            .navigationTitle(area.name).navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(LocalizedStringKey("Cancel")) {
                hideSheetCallback()
            }, trailing: Button(LocalizedStringKey("Save")) {
                area.name = name
                if newImage != nil {
                    let imageName = ImageStorage.save(image: newImage)
                    if (area.imgName != nil) {
                        ImageStorage.delete(imgName: self.area.imgName!)
                    }
                    area.imgName = imageName
                }
                area.objectWillChange.send()
                DataStorage.save()
                hideSheetCallback()
            })
        }
    }
    
    init(hideSheetCallback: @escaping () -> Void, area: Area) {
        self.hideSheetCallback = hideSheetCallback
        self._area = State(initialValue: area)
        self._name = State(initialValue: area.name)
        self._parent = State(initialValue: area.parent)
    }
}
