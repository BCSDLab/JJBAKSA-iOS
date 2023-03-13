//
//  MyPageScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI

struct MyPageScreen: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .frame(width: 46, height: 46)
                            .foregroundColor(.base)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            Text(rootViewModel.user?.nickname ?? "nil")
                                .padding(.bottom, 2)
                                .font(.system(size: 16, weight: .bold))
                            Circle()
                                .frame(width: 2, height: 2)
                                .font(.system(size: 14))
                                .padding(.horizontal, 5)
                            Text("팔로워 \(rootViewModel.user?.userCountResponse?.friendCount ?? 0)")
                        }
                        Text("@\(rootViewModel.user?.account ?? "nil")")
                            .font(.system(size: 14))
                    }
                    .padding(.leading, 13)
                    Spacer()
                    Button(action: {viewModel.toggleIsEditShow()}) {
                        Image(systemName: "gearshape")
                    }
                    .frame(width: 20, height: 20)
                    .foregroundColor(.base)
                }
                .padding(.leading, 16)
                .padding(.top, 36)
                .padding(.trailing, 30)
                .padding(.bottom, 25)
                
                MyPageTabBarView(currentTab: $viewModel.index)
                Divider()
                TabView(selection:$viewModel.index) {
                    MyPostScreen()
                        .tag(0)
                    BookmarkScreen()
                        .tag(1)
                }
                Spacer()
            }
            //UserEditScreen(viewModel: viewModel)
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
                        Text("리뷰")
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
