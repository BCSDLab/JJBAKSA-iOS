//
//  RootScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import SwiftUI

struct RootScreen: View {
    @ObservedObject var viewModel: RootViewModel
    
    init() {
        self.viewModel = RootViewModel()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
