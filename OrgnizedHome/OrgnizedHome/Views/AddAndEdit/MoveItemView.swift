//
//  MoveItemView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/15/21.
//

import SwiftUI

struct MoveItemView: View {
    var hideSheetCallback: () -> Void
    @State private var showAlert = false
    @State var item: Item
    @State var parent: Area
    
    var body: some View {
        NavigationView {
            Form {
                OutlineGroup(DataStorage.storageObject.inventory, children: \.children) { area in
                        AreaRow(area: area)
                        .onTapGesture(perform: {
                            self.item.move(newLocation: area, parent: parent)
                            showAlert.toggle()
                            hideSheetCallback()
                        })
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("\(self.item.name) has been moved."))
            }
            .navigationTitle("Move \(item.name) to...").navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(LocalizedStringKey("Done")) {
                hideSheetCallback()
            })
        }
    }
    
    
}
