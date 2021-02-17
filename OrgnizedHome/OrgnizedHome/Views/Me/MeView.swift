//
//  MeView.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/16/21.
//

import SwiftUI
import AuthenticationServices

struct MeView: View {
    var body: some View {
        ScrollView {
            Text("Features in this tab are not implemented yet. The content is for demo purpose only.")
                .foregroundColor(.secondary)
                .padding()
            Toggle("Sync with iCloud", isOn: Binding.constant(true)).padding()
            Divider()
            SignInWithAppleButton(
                onRequest: { _ in },
                onCompletion: { _ in }
            )
            .frame(width: 250, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            Button("Share inventory with...") {}
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .frame(width: 350, height: 45, alignment: .leading)
            Text("You must sign in to invite people to view or edit your inventory.")
                .foregroundColor(.secondary)
        }
    }
}
