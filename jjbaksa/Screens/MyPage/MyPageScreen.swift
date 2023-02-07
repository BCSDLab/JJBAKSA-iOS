//
//  MyPageScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI

struct MyPageScreen: View {
    @State var index: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "person.circle")
                    .font(.system(size: 60))
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("닉네임")
                            .padding(.bottom, 10)
                            .padding(.trailing, 12)
                            .font(.system(size: 18))
                        Button(action: {()}) {
                            Image(systemName: "pencil")
                        }
                        .font(.system(size: 11))
                        .foregroundColor(.base)
                        .padding(.bottom, 5)
                    }
                    Text("testID")
                        .font(.system(size: 12))
                }
                .padding(.leading, 25)
                Spacer()
            }
            .padding(.leading, 37)
            .padding(.top, 60)
            .padding(.bottom, 33)
            HStack(spacing: 0) {
                Spacer()
                VStack(spacing: 0) {
                    Text("0")
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                    Text("게시글")
                        .font(.system(size: 12))
                }
                .padding(.trailing, 100)
                VStack(spacing: 0) {
                    Text("0")
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                    Text("친구")
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .padding(.bottom, 36)
            MyPageTabBarView(currentTab: $index)
            Divider()
            TabView(selection:$index) {
                MyPostScreen()
                    .tag(0)
                BookmarkScreen()
                    .tag(1)
            }
            Spacer()
        }
    }
}
struct MyPageTabBarView: View {
    @Binding var currentTab: Int

    var body: some View {
        HStack (spacing: 0) {
            Spacer()
            ZStack {
                Button ( action: { self.currentTab = 0 }) {
                    VStack {
                        Text("내가 쓴 글")
                            .font(.system(size: 14))
                            .foregroundColor(.textMain)
                    }
                }
           
                if currentTab == 0 {
                    Capsule()
                        .fill(Color.main)
                        .frame(width: 100, height: 2)
                        .padding(.top, 32)
                        
                } else {
                    Capsule()
                        .fill(.clear)
                        .frame(width: 100, height: 2)
                        .padding(.top, 32)
                }
            }
            .padding(.trailing, 60)
            ZStack {
                Button {
                    self.currentTab = 1
                } label: {
                    VStack {
                        Text("북마크")
                            .font(.system(size: 14))
                            .foregroundColor(.textMain)
                    }
                }
                
                if currentTab == 1 {
                    Capsule()
                        .fill(Color.main)
                        .frame(width: 100, height: 2)
                        .padding(.top, 32)
                } else {
                    Capsule()
                        .fill(.clear)
                        .frame(width: 100, height: 2)
                        .padding(.top, 32)
                }
            }
            Spacer()
        }
    }
}
struct MyPageScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyPageScreen()
    }
}
