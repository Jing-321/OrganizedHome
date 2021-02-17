//
//  ExpiringView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/16/21.
//

import SwiftUI

struct ExpiringView: View {
    var body: some View {
        ScrollView {
            Text("Features in this tab are not implemented yet. The content is for demo purpose only.")
                .foregroundColor(.secondary)
                .padding()
            DisclosureGroup("Expired", isExpanded: Binding.constant(true)) {
                ItemRow(item: Item(id: "demo1", name: "Bananas", note: "Expired 3 days ago", imgName: nil, parent: nil, isFavorite: false))
            }
            .padding()
            DisclosureGroup("Expiring soon", isExpanded: Binding.constant(true)) {
                ItemRow(item: Item(id: "demo2", name: "Milk", note: "Expiring in 2 days", imgName: nil, parent: nil, isFavorite: false))
                ItemRow(item: Item(id: "demo3", name: "Eggs", note: "Expiring in 5 days", imgName: nil, parent: nil, isFavorite: false))
            }
            .padding()
        }
    }
}
