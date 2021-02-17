//
//  MoveView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/9/21.
//

import SwiftUI

struct MoveAreaView: View {
    var hideSheetCallback: () -> Void
    // @State private var showAlert = false
    @State var area: Area
    @State var parent: Area?
    
    var body: some View {
        NavigationView {
            Form {
                OutlineGroup(DataStorage.storageObject.inventory, children: \.children) { area in
                    if area.id != self.area.id && !area.location.contains(where: { self.area.id == $0.id } ) {
                        AreaRow(area: area)
                        .onTapGesture(perform: {
                            self.area.move(newLocation: area, parent: parent!)
                            // showAlert.toggle()
                            hideSheetCallback()
                        })
                    } else {
                        AreaRow(area: area, isDisabled: true)
                    }
                }
            }
            /*
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("\(self.area.name) has been moved."))
            }*/
            .navigationTitle("Move \(area.name) to...").navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(LocalizedStringKey("Done")) {
                hideSheetCallback()
            })
        }
    }
    
    
}
