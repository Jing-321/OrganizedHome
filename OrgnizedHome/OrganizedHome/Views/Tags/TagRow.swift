//
//  TagRow.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/16/21.
//

import SwiftUI

struct TagRow: View {
    var tag: Tag
    
    var body: some View {
        HStack {
            Circle().foregroundColor(tag.displayColor).frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(tag.name)
            Spacer()
        }
    }
}
