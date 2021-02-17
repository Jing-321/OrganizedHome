//
//  AreaView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 1/30/21.
//

import SwiftUI
import AuthenticationServices

enum ActiveSheet: Identifiable {
    case editSheet, moveSheet
    
    var id: Int {
        hashValue
    }
}

struct AreaView: View {
    @State var showSheetView = false
    @State var showEditSheet = false
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @ObservedObject var area: Area
    @State var activeSheet: ActiveSheet? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                if !area.location.isEmpty {
                    LocationInlineView(location: area.location)
                }
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(self.getAreasToShow()) { subArea in
                        NavigationLink(destination: AreaView(area: subArea)) {
                            AreaBlock(area: subArea)
                        }
                        .contextMenu {
                            Button(LocalizedStringKey("Edit"), action: { activeSheet = .editSheet })
                            Button(LocalizedStringKey("Move"), action: { activeSheet = .moveSheet })
                            Divider()
                            Button(LocalizedStringKey("Delete"), action: { subArea.delete() })
                        }
                        .sheet(item: $activeSheet) { item in
                            switch item {
                            case .editSheet:
                                EditAreaView(hideSheetCallback: { activeSheet = nil }, area: subArea)
                            case .moveSheet:
                                MoveAreaView(hideSheetCallback: { activeSheet = nil }, area: subArea, parent: subArea.parent)
                            }
                        }
                    }.onDelete(perform: deleteArea)
                }
                .padding(.horizontal)
                
                ForEach(self.getItemsToShow()) { item in
                    NavigationLink(destination: ItemView(item: item)) {
                        ItemRow(item: item, showLocation: !searchBar.text.isEmpty)
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
                .onDelete(perform: deleteItem)
                
            }
            .navigationTitle(area.parent != nil ? Text(area.name) : Text("My Inventory"))
            .navigationBarItems(trailing:
                HStack{
                    if area.parent != nil {
                        Button(action: {
                            self.showEditSheet.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                        }.sheet(isPresented: $showEditSheet){
                            EditAreaView(hideSheetCallback: { showEditSheet = false }, area: area)
                        }
                        
                        Spacer(minLength: 30)
                    }
                    
                    Button(action: {
                        self.showSheetView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }.sheet(isPresented: $showSheetView) {
                        AddItemView(showSheetView: self.$showSheetView, parent: area)
                    }
                }
            )
            .add(self.searchBar)
        }
    }
    
    func deleteArea(at indexSet: IndexSet) {
        indexSet.forEach({ area.areas[$0].delete() })
        DataStorage.save()
    }
    
    func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach({ area.items[$0].delete() })
        DataStorage.save()
    }
    
    private func getAreasToShow() -> [Area] {
        if searchBar.text.isEmpty {
            return area.areas
        } else {
            return area.descendantAreas.filter({ $0.name.localizedStandardContains(searchBar.text) })
        }
    }
    
    private func getItemsToShow() -> [Item] {
        if searchBar.text.isEmpty {
            return area.items
        } else {
            return area.descendantItems.filter({ $0.name.localizedStandardContains(searchBar.text) })
        }
    }
}

//search bar resource: https://github.com/Geri-Borbas/iOS.Blog.SwiftUI_Search_Bar_in_Navigation_Bar

