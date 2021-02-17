//
//  LocationInlineView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/7/21.
//

import SwiftUI

struct LocationInlineView: View {
    var location: [Area]
    
    @State private var showingActionSheet = false
    @State private var selectedArea: Area = DataStorage.storageObject.inventory
    @State private var triggerNavigate = false
    
    var body: some View {
        HStack {
            Text(location.map({ $0.name }).joined(separator: " \u{25B8} "))
                .foregroundColor(.blue)
                .font(.subheadline)
            Spacer()
            NavigationLink(destination: AreaView(area: selectedArea), isActive: $triggerNavigate) {
                EmptyView()
            }
        }
        .padding()
        .onTapGesture {
            self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Navigate to"), buttons: location.map({ area in
                .default(Text(area.name)) {
                    self.showingActionSheet = false
                    self.selectedArea = area
                    self.triggerNavigate = true
                }
            }) + [.cancel()])
        }
    }
}
