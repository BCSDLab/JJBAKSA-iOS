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
        if(viewModel.token != nil && viewModel.user?.id != nil) {
            MainScreen()
                .environmentObject(viewModel)
        } else {
            LogInScreen()
                .environmentObject(viewModel)
        }
        
        
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
