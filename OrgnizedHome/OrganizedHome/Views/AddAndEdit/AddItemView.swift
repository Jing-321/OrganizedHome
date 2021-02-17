//
//  AddItemView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 1/30/21.
//

import SwiftUI

enum EntityType {
    case Area
    case Item
}

struct AddItemView: View {
    @Binding var showSheetView: Bool
    @State private var typeSelection: EntityType = .Area
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var isShowPhotoLibrary = false
    // @State var image = UIImage()
    @State private var image: UIImage?
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    private var displayImage: Image {
        get {
            image.map({Image(uiImage: $0)}) ?? Image(systemName: "camera.on.rectangle")
        }
    }
    var parent: Area
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $typeSelection, label: Text("Type")) {
                    Text("Area").tag(EntityType.Area)
                    Text("Item").tag(EntityType.Item)
                }
                TextField("Name", text: $name)
                if (typeSelection == EntityType.Item) {
                    TextField("Note", text: $note)
                }
                
                DisplayImageView(image: displayImage, scale: image == nil ? 0.3 : 1)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Add a picture from..."), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            }
            .navigationBarTitle(LocalizedStringKey("Add"), displayMode: .inline)
            .navigationBarItems(leading: Button(LocalizedStringKey("Cancel")) {
                    self.showSheetView = false
                }, trailing: Button(LocalizedStringKey("Save")) {
                    let imageName = ImageStorage.save(image: image)
                    if (typeSelection == EntityType.Item) {
                        parent.items.append(Item(id: nil, name: name, note: note, imgName: imageName, parent: parent, isFavorite: false))
                    } else {
                        parent.areas.append(Area(id: nil, name: name, imgName: imageName, parent: parent, isFavorite: false))
                    }
                    parent.objectWillChange.send()
                    DataStorage.save()
                    self.showSheetView = false
                }.disabled(name == ""))
            
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
