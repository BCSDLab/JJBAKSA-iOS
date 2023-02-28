//
//  UserEditScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/02/27.
//

import SwiftUI

struct UserEditScreen: View {
    @ObservedObject var viewModel: MyPageViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var editScreenHeight = UIScreen.main.bounds.size.height * 0.5
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(viewModel.isEditShow ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: viewModel.isEditShow)
            .onTapGesture {
                viewModel.toggleIsEditShow()
            }
            content
                //.cornerRadius(20)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 0) {
                Text("\(rootViewModel.user?.nickname ?? "")님,\n프로필을 변경하시겠어요?")
                    .size18Regular()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 30)
                    .padding(.leading, 24)
                ZStack {
                    Circle()
                        .frame(width: 110, height: 110)
                        .foregroundColor(.base)
                    Button(action: {()}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 25))
                            .foregroundStyle(.black, Color.base)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    }
                    .foregroundColor(.base)
                    .padding(.leading, 85)
                    .padding(.top, 85)
                }
                .padding(.bottom, 25)
                HStack(spacing: 0) {
                    TextField(rootViewModel.user?.nickname ?? "", text: $viewModel.newNickname)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .padding(.leading, 112)
                        .padding(.trailing, 47)
                        .size14Regular()
                    if viewModel.newNickname.isEmpty {
                        Text("\(rootViewModel.user?.nickname?.count ?? 0)/\(viewModel.limit)")
                            .padding(.trailing, 110)
                            .size10Regular()
                            .foregroundColor(.base)
                    } else {
                        Text("\(viewModel.newNickname.count)/\(viewModel.limit)")
                            .padding(.trailing, 110)
                            .size10Regular()
                            .foregroundColor(.base)
                    }
                }
                .padding(.bottom, 2)
                
                Divider()
                    .padding(.horizontal, 100)
                    
                    .frame(width: 200, height: 1)
                    .background(Color.base)
                
                HStack(spacing: 0) {
                    Button(action: {
                        viewModel.toggleIsEditShow()
                        viewModel.deleteNewNickname()}) {
                        Text("취소")
                            .frame(width: 141, height: 40)
                            .size14Regular()
                            .foregroundColor(.textSub)
                            .background(Capsule().fill(Color.base))
                    }
                    .padding(.trailing, 41)
                    Button(action: { rootViewModel.changeNickname(nickname: viewModel.newNickname)
                        //위 아래 코드 모두 사용 가능
                        //rootViewModel.changeUserInfo(account: nil, email: nil, password: nil, nickname: viewModel.newNickname)
                        viewModel.toggleIsEditShow()
                    }) {
                        Text("완료")
                            .frame(width: 141, height: 40)
                            .size14Regular()
                            .foregroundColor(.textSub)
                            .background(Capsule().fill(Color.main))
                    }
                }
                .padding(.top, 50)
            }
        }
        .frame(height: editScreenHeight)
        .offset(y: viewModel.isEditShow ? 0.5 * editScreenHeight : 2 * editScreenHeight)
        .animation(.default, value: viewModel.isEditShow)
    }
}


struct UserEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserEditScreen(viewModel: MyPageViewModel())
    }
}
