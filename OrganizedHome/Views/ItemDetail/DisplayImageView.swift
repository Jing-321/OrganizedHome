//
//  DisplayImageView.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/7/21.
//

import SwiftUI

struct DisplayImageView: View {
    var image: Image
    var scale: CGFloat = 1
    
    var body: some View {
        image
            .resizable()
            .scaleEffect(scale)
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .padding()
    }
}
