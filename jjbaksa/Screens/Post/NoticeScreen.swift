//
//  NoticeView.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import SwiftUI

struct NoticeScreen: View {
    @StateObject var viewModel: NoticeViewModel = NoticeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if(viewModel.notice?.content == nil){
                if(viewModel.status == nil) {
                    ProgressView(label: {
                        VStack(spacing : 0) {
                            Text("로딩 중..")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    ).progressViewStyle(CircularProgressViewStyle())
                } else if viewModel.status == false { //로딩 실패 시 실패 메세지 출력.
                    Spacer()
                    Text("Loading Failed.")
                }
            } else {
                Divider()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 2)
                
                ScrollView {
                    ForEach(viewModel.notice!.content, id: \.self) { post in
                        NoticeRow(post: post)
                            .padding(.leading, 16)
                        
                        Divider()
                            .padding(.horizontal, 16)
                        
                    }
                    if(!(viewModel.notice?.content.isEmpty ?? true) && viewModel.notice?.content.count ?? 0 < viewModel.notice?.totalElements ?? 0){
                        ProgressView()
                            .onAppear() {
                                viewModel.getNewNotice()
                            }
                    }
                }
                .scrollIndicators(.hidden)
             
            }
        }
        .onAppear() {
            viewModel.getNotice()
        }
    }
}
