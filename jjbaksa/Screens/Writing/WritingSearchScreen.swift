//
//  WritingSearchScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import SwiftUI

struct WritingSearchScreen: View {
    @ObservedObject var viewModel: WritingSearchViewModel
    
    init() {
        self.viewModel = WritingSearchViewModel()
    }
    
    var body: some View {
        SearchView(viewModel: viewModel) {(item: WritingSearchViewModel.itemType) in
            WritingSearchRow(shop: item)
        }
    }
}

struct WritingSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        WritingSearchScreen()
    }
}
