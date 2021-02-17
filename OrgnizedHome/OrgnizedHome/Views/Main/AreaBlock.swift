//
//  AreaRow.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 1/31/21.
//

import Foundation
import SwiftUI

struct AreaBlock: View {
    @ObservedObject var area: Area
    @State var activeSheet: ActiveSheet?
    
    var body: some View {
        ZStack (alignment: .topTrailing, content: {
            area.img
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .cornerRadius(10.0)
                .overlay(Text(area.name)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 2, x: 3, y: 3)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0)),
                         alignment: .bottomLeading)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 2, x: 2, y: 2)
        })
    }
}
