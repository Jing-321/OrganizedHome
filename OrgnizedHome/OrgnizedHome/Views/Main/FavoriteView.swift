//
//  FavoriteView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/16/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var inventory = DataStorage.storageObject.inventory
    
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
                Divider()
            }
        }
        .navigationTitle("Favorites")
    }
}

