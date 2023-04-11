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
        PaginationView(viewModel: viewModel) {(item: NoticeViewModel.itemType) in
            NoticeRow(post: item)
        }
    }
}
