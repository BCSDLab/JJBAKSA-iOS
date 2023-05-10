//
//  SearchView.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import SwiftUI

struct SearchView<T, Content: View>: View where T: SearchProtocol, T: PaginationProtocol {
    @ObservedObject var viewModel: T
    var row:(T.itemType) -> Content
    @State var currentIndex: Int = 0
    @State var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init(viewModel: T, @ViewBuilder content: @escaping (T.itemType) -> Content ) {
        self.viewModel = viewModel
        self.row = content
        self.viewModel.getTrending()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                CustomTextField("검색어를 입력해주세요.", fontSize: 16, fontWeight: .medium, fontColor: .textMain, textPadding: 16, width: 343, height: 48, backgroundColor: Color.textSub, shadow: true, text: $viewModel.searchText)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.getAutoComplete() //TODO: 연관 검색어 API 나올 시 적용
                        if viewModel.isButtonPressed {
                            viewModel.isButtonPressed = false
                        } else {
                            viewModel.isSearched = false
                            viewModel.emptyShopList()
                        }
                    }
                
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        if !viewModel.searchText.isEmpty {
                            
                            viewModel.searchShopList(searchText: nil)
                            
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.textMain)
                            .font(.system(size: 18))
                    }
                    .padding(.trailing, 35)
                }
            }
            .padding(.bottom, 12)
            

            if viewModel.isSearched {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(viewModel.totalElement)개의 검색결과")
                        .size12Medium()
                        .foregroundColor(.main)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    
                    PaginationView(viewModel: viewModel, content: row)
                        .ignoresSafeArea()
                    
                    Spacer()
                }
            } else {
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) { //TODO: 자동으로 ScrollView가 오른쪽에서 왼쪽으로 흐르는 애니매이션.
                        
                        HStack(spacing: 0) {
                            ForEach(viewModel.trendings.indices, id: \.self) { index in
                                Button(action: {
                                    viewModel.searchShopList(searchText: viewModel.trendings[index].text)
                                    viewModel.isButtonPressed = true
                                }) {
                                    ZStack {
                                        Capsule()
                                            .strokeBorder(viewModel.trendings[index].isPressed ? Color.main : Color.munan)
                                            .background(Capsule()
                                                .fill(viewModel.trendings[index].isPressed ? Color.sub.opacity(0.2) : Color.textSub))
                                            .frame(height: 27)
                                        HStack(spacing: 0) {
                                            Text("# \(viewModel.trendings[index].text)")
                                                .size12Medium()
                                                .foregroundColor(viewModel.trendings[index].isPressed ? Color.main : Color.munan)
                                                .padding(.horizontal, 8)
                                        }
                                    }
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged({ _ in
                                            viewModel.trendings[index].isPressed = true
                                        })
                                        .onEnded({ _ in
                                            viewModel.trendings[index].isPressed = false
                                        })
                                )
                                .buttonStyle(StaticButtonStyle())
                                .animation(.easeInOut(duration: 1.0))
                                .padding(.horizontal, 4)
                            }
                        }
                    }
                    .onReceive(timer) { _ in
                        withAnimation(Animation.easeInOut(duration: 1)){
                            currentIndex = (currentIndex + 1) % viewModel.trendings.count
                            scrollView.scrollTo(currentIndex, anchor: .center)
                        }
                    }
                }
                
                if !viewModel.autoCompletes.isEmpty {
                    VStack(spacing: 0) {
                        //TODO: 자동완성 API 구현 시 구현.
                        /*
                        ForEach(viewModel.searchedShops.indices, id: \.self) { index in
                            Button(action: {()}) {
                                HStack(spacing: 0) {
                                    Image(systemName: "location")
                                        .font(.system(size: 11))
                                        .padding(.leading, 14)
                                        .padding(.trailing, 6)
                                    Text(viewModel.searchedShops[index].name)
                                        .size14Medium()
                                    Spacer()
                                }
                                .foregroundColor(viewModel.searchedShops[index].isPressed ? .main : .textMain)
                                .frame(maxWidth: .infinity, maxHeight: 42)
                                .background(viewModel.searchedShops[index].isPressed ? Color(hex: "#F7F7F7") : Color.textSub)
                                .cornerRadius(20)
                            }
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ _ in
                                        viewModel.searchedShops[index].isPressed = true
                                    })
                                    .onEnded({ _ in
                                        viewModel.searchedShops[index].isPressed = false
                                    })
                            )
                            .buttonStyle(StaticButtonStyle())
                            .padding(.horizontal, 16)
                        }
                        */
                    }
                    .padding(.top, 6)
                }
                
                if !viewModel.recentSearches.isEmpty {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("최근 검색")
                                .size12Medium()
                                .foregroundColor(.main)
                                .padding(.leading, 26)
                            Spacer()
                            Button(action: { viewModel.deleteAllRecentSearch() }) {
                                Text("전체삭제")
                                    .size12Medium()
                                    .foregroundColor(.main)
                            }
                            .padding(.trailing, 23)
                        }
                        .padding(.bottom, 4)
                        
                        ForEach(viewModel.recentSearches.indices, id: \.self) { index in
                            Button(action: {
                                viewModel.searchShopList(searchText: viewModel.recentSearches[index].text)
                                viewModel.isButtonPressed = true
                                }) {
                                HStack(spacing: 0) {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .foregroundColor(.textMain)
                                        .font(.system(size: 11))
                                        .padding(.leading, 14)
                                        .padding(.trailing, 6)
                                    Text(viewModel.recentSearches[index].text)
                                        .size14Medium()
                                        .foregroundColor(.textMain)
                                    
                                    Spacer()
                                    
                                    Button(action: { viewModel.deleteRecentSearch(index: index) }) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 8))
                                            .foregroundColor(.munan)
                                    }
                                    .padding(.trailing, 14)
                                }
                                .frame(maxWidth: .infinity, maxHeight: 33)
                                .background(viewModel.recentSearches[index].isPressed ? Color(hex: "#F7F7F7") : Color.textSub)
                                .cornerRadius(20)
                            }
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ _ in
                                        viewModel.recentSearches[index].isPressed = true
                                    })
                                    .onEnded({ _ in
                                        viewModel.recentSearches[index].isPressed = false
                                    })
                            )
                            .buttonStyle(StaticButtonStyle())
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 24)
                }
                Spacer()
            }
        }
    }
}
