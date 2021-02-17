//
//  ItemView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 1/30/21.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var item: Item
    @State var showEditSheet = false
    var starStatus: String {
        get {item.isFavorite ? "star.fill" : "star"}
    }
    
    var body: some View {
        ScrollView {
            LocationInlineView(location: item.location)
            Divider()
            if item.note != nil && !item.note!.isEmpty {
                HStack {
                    Text(item.note!)
                    Spacer()
                }
                .padding()
            }
            DisplayImageView(image: item.img)
        }
        .navigationTitle(item.name)
        .navigationBarItems(trailing:
                                HStack{
                                    Button(action: {
                                        item.toggleFavorite()
                                    }, label: {
                                        Image(systemName: "\(starStatus)")
                                    })
                                    
                                    Spacer(minLength: 30)
                                    
                                    Button(action: {
                                        self.showEditSheet.toggle()
                                    }) {
                                        Image(systemName: "pencil")
                                            .imageScale(.large)
                                    }.sheet(isPresented: $showEditSheet){
                                        EditItemView(hideSheetCallback: { showEditSheet = false }, item: item)
                                    }
                                })
                                
    }
}
