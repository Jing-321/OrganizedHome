//
//  ContentView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 1/28/21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                AreaView(area: DataStorage.storageObject.inventory)
                .navigationTitle("My Inventory")
            }
                .tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Inventory")
                }
            
            NavigationView {
                TagsView(tags: DataStorage.storageObject.tags)
                .navigationTitle("Tags")
            }
                .tabItem {
                    Image(systemName: "tag.fill")
                    Text("Tags")
                }
            
            NavigationView {
                FavoriteView()
                .navigationTitle("Favorites")
            }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            
            NavigationView {
                ExpiringView()
                .navigationTitle("Expiring")
            }
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Expiring")
                }
            
            NavigationView {
                MeView()
                .navigationTitle("Me")
            }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Me")
                }
        }
    }
}
