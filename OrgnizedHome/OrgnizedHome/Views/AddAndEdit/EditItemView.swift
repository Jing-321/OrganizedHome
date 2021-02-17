//
//  EditItemView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/15/21.
//

import SwiftUI

struct EditItemView: View {
    var hideSheetCallback: () -> Void
    @State var item: Item
    @State private var name: String
    @State private var note: String?
    @State private var noteText: String
    @State private var selectedAreaIndex = 0
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentCamera = false
    @State private var isShowPhotoLibrary = false
    @State var newImage: UIImage?
    private var displayImage: Image {
        get {newImage == nil ? item.img : Image(uiImage: self.newImage!)}
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Note", text: $noteText)
                
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
            .navigationTitle(item.name).navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(LocalizedStringKey("Cancel")) {
                hideSheetCallback()
            }, trailing: Button(LocalizedStringKey("Save")) {
                item.name = name
                item.note = noteText.isEmpty ? Optional.none : Optional(noteText)
                if newImage != nil {
                    let imageName = ImageStorage.save(image: newImage)
                    if (item.imgName != nil) {
                        ImageStorage.delete(imgName: self.item.imgName!)
                    }
                    item.imgName = imageName
                }
                item.objectWillChange.send()
                item.parent!.objectWillChange.send()
                DataStorage.save()
                hideSheetCallback()
            })
        }
    }
    
    init(hideSheetCallback: @escaping () -> Void, item: Item) {
        self.hideSheetCallback = hideSheetCallback
        self._item = State(initialValue: item)
        self._name = State(initialValue: item.name)
        self._note = State(initialValue: item.note)
        self._noteText = State(initialValue: item.note ?? "")
    }
}

