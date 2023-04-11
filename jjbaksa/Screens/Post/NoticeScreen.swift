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
            if(viewModel.isLoading){
                ProgressView(label: {
                    VStack(spacing : 0) {
                        Text("로딩 중..")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                ).progressViewStyle(CircularProgressViewStyle())
            } else {
                Divider()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 2)
                
                ScrollView {
                    ForEach(viewModel.notice!.content, id: \.self) { post in
                        NoticeRow(post: post)
                            .padding(.leading, 16)
                    }
                    if(viewModel.hasMore){
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
