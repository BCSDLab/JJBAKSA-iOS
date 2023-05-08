//
//  PaginationView.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/11.
//

import SwiftUI

struct PaginationView<T: PaginationProtocol, Content: View>: View {
    @ObservedObject var viewModel: T
    var item: (T.itemType) -> Content
    
    init(viewModel: T, @ViewBuilder content: @escaping (T.itemType) -> Content) {
        self.viewModel = viewModel
        self.item = content
    }
    
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
                ScrollView {
                    ForEach(viewModel.list!.indices, id: \.self) { index in
                        item(viewModel.list![index])
                    }
                    if(viewModel.hasMore) {
                        ProgressView()
                            .onAppear() {
                                viewModel.getNextList()
                            }
                    }
                }
             
            }
        }
        .onAppear() {
            viewModel.getList()
        }
    }
}
