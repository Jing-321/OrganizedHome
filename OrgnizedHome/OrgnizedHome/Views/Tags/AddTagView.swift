//
//  AddTagView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/11/21.
//

import SwiftUI

struct AddTagView: View {

    @Binding var showSheetView: Bool
    @State private var name: String = ""
    @State private var color: TagColor = .blue
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            // ColorPicker("Color", selection: $color)
        }
        .navigationBarTitle("Add a tag", displayMode: .inline)
        .navigationBarItems(leading: Button("Cancel"){
                self.showSheetView = false
            }, trailing: Button("Save"){
                DataStorage.storageObject.tags.append(Tag(name: name, color: color))
                DataStorage.save()
                self.showSheetView = false
            }.disabled(name == ""))
    }
    
    init(showSheetView: Binding<Bool>) {
        self._showSheetView = showSheetView
    }
}
