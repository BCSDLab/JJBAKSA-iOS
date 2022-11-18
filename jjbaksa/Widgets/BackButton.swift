//
//  BackButton.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/18.
//

import SwiftUI

struct BackButton: ToolbarContent {
    @Binding var presentation: PresentationMode
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action : {
                self.$presentation.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            
        }
    }
}
