//
//  AreaRow.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/13/21.
//

import SwiftUI

struct AreaRow: View {
    var area: Area
    var isDisabled = false
    
    var body: some View {
        HStack {
            area.img
                .resizable()
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .grayscale(isDisabled ? 1 : 0)
            Text(area.name)
                .foregroundColor(isDisabled ? .secondary : .primary)
        }
    }
}
