//
//  MyPost.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/02/07.
//

import SwiftUI

struct MyReviewScreen: View {
    @StateObject var viewModel: MyReviewViewModel = MyReviewViewModel()
    
    var body: some View {
        PaginationView(viewModel: viewModel) {(item: MyReviewViewModel.itemType) in
            MyReviewRow(review: item, totalElement: viewModel.totalElement, firstElementID: viewModel.firstElementID)
        }
    }
}

