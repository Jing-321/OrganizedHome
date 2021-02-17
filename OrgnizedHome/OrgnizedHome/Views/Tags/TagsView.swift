//
//  TagsView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/8/21.
//

import SwiftUI

struct TagsView: View {
    
    @State var showSheetView = false
    var tags: [Tag]
    
    var body: some View {
        /*
        List(tags) { tag in
            Text(tag.name)
        }
        .navigationBarItems(trailing:
            HStack{
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }.sheet(isPresented: $showSheetView) {
                    AddTagView(showSheetView: self.$showSheetView)
                }
            }
        )*/
        VStack {
            Text("Features in this tab are not implemented yet. The content is for demo purpose only.")
                .foregroundColor(.secondary)
                .padding()
            List {
                TagRow(tag: Tag(name: "Book", color: .blue))
                TagRow(tag: Tag(name: "Toy", color: .yellow))
                TagRow(tag: Tag(name: "Cookware", color: .red))
                TagRow(tag: Tag(name: "Shoes", color: .green))
            }
        }
        .navigationBarItems(trailing:
            HStack{
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }.sheet(isPresented: $showSheetView) {
                    AddTagView(showSheetView: self.$showSheetView)
                }
            }
        )
    }
}
