//
//  MainScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI

struct MainScreen: View {
    @State var index = 0
    @ObservedObject var myPageViewModel = MyPageViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    TabView(selection:$index) {
                        MapScreen()
                            .tag(0)
                        MyPageScreen()
                            .environmentObject(myPageViewModel)
                            .tag(1)
                    }
                    .onAppear {
                        UITabBar.appearance().backgroundColor = .white
                    }
                    TabBarView(currentTab: $index)
                }
            }
        }
        .popup(isPresented: $myPageViewModel.isEditShow) {
            UserEditScreen()
                .environmentObject(myPageViewModel)
        } customize: {
            $0
                .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                .position(.bottom)
                .animation(.spring())
                .closeOnTapOutside(false)
                .backgroundColor(.black.opacity(0.35))
        }
    }
}


struct TabBarView: View {
    @Binding var currentTab: Int

    var body: some View {
        
        HStack (spacing: 0) {
            ZStack {
                Button {
                    self.currentTab = 0
                } label: {
                    VStack {
                        Image(systemName: "house")
                            .padding(.bottom, 3)
                        Text("홈")
                            .font(.system(size: 12))
                            .padding(.bottom, 28)
                        
                        
                    }
                }
                .frame(height: 100)
                .foregroundColor(currentTab == 0 ? Color.textMain : Color.base)
                
                if currentTab == 0 {
                    Capsule()
                        .fill(Color.textMain)
                        .frame(height: 2)
                        .padding(.bottom, 112)
                } else {
                    Capsule()
                        .fill(.clear)
                        .frame(height: 2)
                        .padding(.bottom, 112)
                }
            }
            NavigationLink(destination: PostScreen() ) {
                ZStack {
                    VStack {
                        Image(systemName: "pencil")
                            .padding(.bottom, 3)
                        Text("글쓰기")
                            .font(.system(size: 12))
                            .padding(.bottom, 28)
                       
                    }
                    Capsule()
                        .fill(.clear)
                        .frame(height: 2)
                        .padding(.bottom, 112)
                }
                
                
            }
            .frame(height: 100)
            .foregroundColor(Color.base)
            
            
            
            ZStack {
                Button {
                    self.currentTab = 1
                } label: {
                    VStack {
                        Image(systemName: "person")
                            .padding(.bottom, 3)
                        Text("마이페이지")
                            .font(.system(size: 12))
                            .padding(.bottom, 28)
                        
                        
                    }
                    
                }
                .frame(height: 100)
                .foregroundColor(currentTab == 1 ? Color.textMain : Color.base)
                if currentTab == 1 {
                    Capsule()
                        .fill(Color.textMain)
                        .frame(height: 2)
                        .padding(.bottom, 112)
                } else {
                    Capsule()
                        .fill(.clear)
                        .frame(height: 2)
                        .padding(.bottom, 112)
                }
            }
        }
        .frame(height: 0)

    }
}



struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
