//
//  WritingImagePicker.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/08.
//

import SwiftUI
import PhotosUI

struct WritingImagePicker: View {
    @ObservedObject var viewModel: ImagePickerViewModel
    @EnvironmentObject var WritingViewModel: WritingViewModel
    @Environment(\.presentationMode) var presentation
    
    init(pickedImages: [ImageAsset]) {
        self.viewModel = ImagePickerViewModel(pickedImages: pickedImages)
    }
    
 
    var body: some View {
        let deviceSize = UIScreen.main.bounds.size
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 3), spacing: 8) {
                    ForEach($viewModel.fetchedImages) { $imageAsset in
                        GridContent(imageAsset: imageAsset, size: deviceSize)
                            .onAppear() {
                                if imageAsset.thumbnail == nil {
                                    let manager = PHCachingImageManager.default()
                                    manager.requestImage(for: imageAsset.asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { image, _ in
                                        imageAsset.thumbnail = image
                                    }
                                }
                            }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("최근 항목"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 0) {
                    Text("\(viewModel.selectedImages.count)")
                        .size16Bold()
                        .foregroundColor((viewModel.selectedImages.count < 10) ? .main : .base)
                        .padding(.trailing, 2)
                    Button(action: {
                        WritingViewModel.pickImages(selectedImages: viewModel.selectedImages)
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("완료")
                            .size16Medium()
                            .foregroundColor(.textMain)
                    }
                    .padding(.trailing, 5)
                }
            }
        }
    }
    
    func GridContent(imageAsset: ImageAsset, size: CGSize) -> some View {
        ZStack {
            let imageSize: CGFloat = size.width * 0.28
            if let thumbnail = imageAsset.thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
                    .contentShape(Rectangle())
                    .overlay(Rectangle()
                        .strokeBorder(Color.main.opacity((viewModel.selectedImages.firstIndex(where: { asset in
                            asset.asset == imageAsset.asset
                        }) != nil) ? 1 : 0), lineWidth: 3)
                        )
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize, alignment: .center)
            }
            ZStack {
                if let index = viewModel.selectedImages.firstIndex(where: { asset in
                    asset.asset == imageAsset.asset
                }) {
                    Circle()
                        .fill(Color.main)
                    Text("\(viewModel.selectedImages[index].assetIndex + 1)")
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .stroke(.white, lineWidth: 1)
                }
            }
            .frame(width: 16, height: 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.top, 8)
            .padding(.trailing, 12)
        }
        .onTapGesture() {
            if viewModel.selectedImages.count < 10 {
                withAnimation(.easeInOut) {
                    if let index = viewModel.selectedImages.firstIndex(where: { asset in
                        asset.asset == imageAsset.asset
                    }) {
                        viewModel.removeImage(index: index)
                    } else {
                        viewModel.addImage(imageAsset: imageAsset)
                    }
                }
            }
        }
    }
}

