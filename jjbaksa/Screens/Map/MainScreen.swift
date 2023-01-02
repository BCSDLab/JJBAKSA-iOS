//
//  MainScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI

struct MainScreen: View {
    @State var index = 0
    
    var body: some View {
        NavigationView {
            VStack{
                TabView(selection:$index) {
                    MapScreen()
                        .tag(0)
                    MyPageScreen()
                        .tag(1)
                }
                .onAppear {
                    UITabBar.appearance().backgroundColor = .white
                }
                TabBarView(currentTab: $index)
            }
        }
    }
}


struct TabBarView: View {
    @Binding var currentTab: Int

    var body: some View {
        
        HStack (spacing: 0) {
            Spacer()
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
                .frame(width:120, height: 100)
                .foregroundColor(currentTab == 0 ? Color.textMain : Color.base)
                
                //TODO: 각 버튼의 비율을 GeometryReader를 사용하여 비율을 정해야 할 지?
                if currentTab == 0 {
                    Capsule()
                        .fill(Color.textMain)
                        .frame(width:120, height: 2)
                        .padding(.bottom, 112)
                }
            }
            Spacer()
            
            NavigationLink(destination: PostScreen() ) {
                VStack {
                    Image(systemName: "pencil")
                        .padding(.bottom, 3)
                    Text("글쓰기")
                        .font(.system(size: 12))
                        .padding(.bottom, 28)
                   
                }
                
            }
            .frame(width: 120, height: 100)
            .foregroundColor(Color.base)
            
            Spacer()
            
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
                .frame(width: 120, height: 100)
                .foregroundColor(currentTab == 1 ? Color.textMain : Color.base)
                if currentTab == 1 {
                    Capsule()
                        .fill(Color.textMain)
                        .frame(width:120, height: 2)
                        .padding(.bottom, 112)
                }
            }
            Spacer()
        }
        .frame(height: 0)

    }
}

//TODO: Item 선택 시 검은 선으로 Highlight



struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
