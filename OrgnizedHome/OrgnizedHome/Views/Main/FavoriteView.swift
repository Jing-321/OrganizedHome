//
//  FavoriteView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/16/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var inventory = DataStorage.storageObject.inventory
    @State var activeSheet: ActiveSheet? = nil
    
    var favoriteItems: [Item] {
        get {
            return inventory.descendantItems.filter({ $0.isFavorite })
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(favoriteItems) {item in
                NavigationLink (
                    destination: ItemView(item: item)) {
                        ItemRow(item: item)
                    }
                .contextMenu {
                    Button(LocalizedStringKey("Edit"), action: { activeSheet = .editSheet })
                    Button(LocalizedStringKey("Move"), action: { activeSheet = .moveSheet })
                    Button(LocalizedStringKey(item.isFavorite ? "Unfavorite" : "Favorite"), action: { item.toggleFavorite() })
                    Divider()
                    Button(LocalizedStringKey("Delete"), action: { item.delete() })
                }
                .sheet(item: $activeSheet) { sheetItem in
                    switch sheetItem {
                    case .editSheet:
                        EditItemView(hideSheetCallback: { activeSheet = nil }, item: item)
                    case .moveSheet:
                        MoveItemView(hideSheetCallback: { activeSheet = nil }, item: item, parent: item.parent!)
                    }
                }
                Divider()
            }
        }
        .navigationTitle("Favorites")
    }
}

