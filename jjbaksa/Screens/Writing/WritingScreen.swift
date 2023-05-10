//
//  WritingScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI
import UIKit

struct WritingScreen: View {
    @ObservedObject var viewModel: WritingViewModel
    
    init(shop: Shop) {
        self.viewModel = WritingViewModel(shop: shop)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 25))
                        .foregroundColor((index <= viewModel.rate) ? .main : .line)
                        .onTapGesture() {
                            viewModel.setRate(index: index)
                        }
                }
            }
            .padding(.bottom, 30)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                .frame(height: 2)
                .foregroundColor(.base)
                .padding(.horizontal, 24)
                .padding(.bottom, 17)
            
            HStack(spacing: 0) {
                NavigationLink(destination: WritingImagePicker(pickedImages: viewModel.pickedImages)
                    .environmentObject(viewModel)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(Color.main)
                                .frame(width: 31, height: 31)
                            Image(systemName: "plus")
                                .frame(width: 12, height: 12)
                                .foregroundColor(.main)
                        }
                        .padding(.leading, 32)
                        .padding(.trailing, 16)
                    }
                if viewModel.pickedImages.isEmpty {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("사진 첨부")
                            .size16Regular()
                            .foregroundColor(.textMain)
                            .padding(.bottom, 4)
                        Text("최대 10장까지 첨부할 수 있어요!")
                            .size12Regular()
                            .foregroundColor(.munan)
                        
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.pickedImages.indices, id: \.self) { index in
                                ZStack {
                                    Image(uiImage: viewModel.pickedImages[index].thumbnail!)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .padding(.trailing, 4)
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.textSub)
                                            .opacity(0.8)
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(.main)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(.leading, 3)
                                    .padding(.bottom, 3)
                                    .font(.system(size: 18))
                                    .onTapGesture() {
                                        viewModel.removeImage(index: index)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                Spacer()
            }
            .frame(height: 86)
            .padding(.bottom, 21)
            
            //ScrollView(showsIndicators: true) { //TODO: 스크롤이 꼭 필요한지 물어보기.
            TextEditor(text: $viewModel.content)
                .accentColor(.textMain)
                .padding(.horizontal, 24)
                .size16Regular()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            //}
        }
        .navigationBarTitle(Text("\(viewModel.shop.placeName)"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.postReview()
                }) {
                    ZStack {
                        Capsule()
                            .strokeBorder(Color.main, lineWidth: 1)
                        Text("저장")
                            
                            .size12Regular()
                            .foregroundColor(.main)
                    }
                    .frame(width: 44, height: 30)
                    
                }
                .padding(.trailing, 8)
                
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}


struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
