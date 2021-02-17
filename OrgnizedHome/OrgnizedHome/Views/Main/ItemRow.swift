//
//  listRow.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 1/31/21.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    @ObservedObject var item: Item
    var showLocation: Bool = false
    @State var activeSheet: ActiveSheet?
    
    var body: some View {
        HStack(alignment: .top) {
            item.img
                .resizable()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
            VStack {
                HStack {
                    Text(item.name)
                        .font(.body)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    if showLocation {
                        Text(item.location.map({ $0.name }).joined(separator: " > "))
                            .foregroundColor(.secondary)
                    } else if item.note != nil && !item.note!.isEmpty {
                        Text(item.note!)
                            .foregroundColor(.secondary)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
    }
    
    func deleteItem() {
        self.item.parent!.items.removeAll(where: {$0.id == self.item.id})
        DataStorage.save()
        item.parent?.objectWillChange.send()
    }
}
