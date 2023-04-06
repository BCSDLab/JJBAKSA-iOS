//
//  RootScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import SwiftUI

struct RootScreen: View {
    @StateObject var viewModel: RootViewModel = RootViewModel()
    
    
    var body: some View {
        if(viewModel.token != nil && viewModel.user?.id != nil) {
            MainScreen()
                .environmentObject(viewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { output in
                    viewModel.shutDown()
         })
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
