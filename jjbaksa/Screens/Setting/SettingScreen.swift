//
//  SettingScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: SettingViewModel = SettingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("계정 관리")
                .frame(maxWidth: .infinity, alignment: .leading)
                .size14Regular()
                .foregroundColor(.main)
                .padding(.leading, 16)
                .padding(.top, 53)
                .padding(.bottom, 4)
            Group {
                NavigationLink(destination: ChangeAccountScreen()) {
                    HStack(spacing: 0) {
                        Text("아이디 변경")
                            .size16Regular()
                            .padding(.leading, 16)
                            .foregroundColor(.textMain)
                        Spacer()
                        Text(rootViewModel.user?.account ?? "")
                            .size14Regular()
                            .padding(.trailing, 14)
                            .foregroundColor(.main)
                        Image(systemName: "chevron.forward")
                            .size14Regular()
                            .padding(.trailing, 24)
                            .foregroundColor(.base)
                    }
                    .padding(.vertical, 8)
                }
                
                NavigationLink(destination: ChangPasswordScreen()) {
                    HStack(spacing: 0) {
                        Text("비밀번호 변경")
                            .size16Regular()
                            .padding(.leading, 16)
                            .foregroundColor(.textMain)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .size14Regular()
                            .padding(.trailing, 24)
                            .foregroundColor(.base)
                    }
                    .padding(.vertical, 8)
                }
                Button(action: {()}) {
                    HStack(spacing: 0) {
                        Text("개인정보 이용방침")
                            .size16Regular()
                            .padding(.leading, 16)
                            .foregroundColor(.textMain)
                        Spacer()
                        Image(systemName: "link")
                            .size14Regular()
                            .padding(.trailing, 19)
                            .foregroundColor(.base)
                    }
                    .padding(.vertical, 8)
                }
            }
            
            Text("서비스")
                .frame(maxWidth: .infinity, alignment: .leading)
                .size14Regular()
                .foregroundColor(.main)
                .padding(.leading, 16)
                .padding(.top, 40)
                .padding(.bottom, 4)
            
            Group {
                NavigationLink(destination: NoticeScreen()) {
                    HStack(spacing: 0) {
                        Text("공지사항")
                            .size16Regular()
                            .padding(.leading, 16)
                            .foregroundColor(.textMain)
                        Spacer()
                        Image(systemName: "link")
                            .size14Regular()
                            .padding(.trailing, 19)
                            .foregroundColor(.base)
                    }
                    .padding(.vertical, 8)
                }
                
                Button(action: {()}) {
                    HStack(spacing: 0) {
                        Text("문의하기")
                            .size16Regular()
                            .padding(.leading, 16)
                            .foregroundColor(.textMain)
                        Spacer()
                        Image(systemName: "link")
                            .size14Regular()
                            .padding(.trailing, 19)
                            .foregroundColor(.base)
                    }
                    .padding(.vertical, 8)
                }
                HStack(spacing: 0) {
                    Text("앱 버전")
                        .size16Regular()
                        .padding(.leading, 16)
                        .foregroundColor(.textMain)
                    if(viewModel.isNowVersionLatest == false) {
                        Image(systemName: "exclamationmark.circle")
                            .frame(width: 15, height: 15)
                            .foregroundColor(.main)
                            .padding(.leading, 6.5)
                    }
                    Spacer()
                    Text("현재 \(viewModel.nowVersion ?? "0.0") / 최신 0.0")
                    //Text("현재 \(viewModel.nowVersion ?? "0.0") / 최신 \(viewModel.latestVersion() ?? "0.0")") //TODO: 앱 출시 시 적용
                        .size14Regular()
                        .padding(.trailing, 20)
                        .foregroundColor(.main)
                }
                .padding(.vertical, 8)
            }
            Spacer()
            
            Button(action: { rootViewModel.logOut() }) {
                Text("로그아웃")
                    .size16Regular()
                    .foregroundColor(.textMain)
                    .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            Button(action: {()}) {
                Text("탈퇴하기")
                    .foregroundColor(.base)
                    .underline()
                    .size14Regular()
                    .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .padding(.bottom, 31)
        }
    }
}

