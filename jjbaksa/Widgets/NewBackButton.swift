//
//  NewBackButton.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/27.
//

import SwiftUI

struct NewBackButton: ToolbarContent {
    @Binding var path: NavigationPath
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action : {
                self.path.removeLast()
            }){
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            
        }
    }
}
