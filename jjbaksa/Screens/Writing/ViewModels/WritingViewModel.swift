//
//  WritingViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/08.
//

import Foundation
import PhotosUI

class WritingViewModel: ObservableObject {
    let shop: Shop
    @Published var content: String = ""
    @Published var isShowPhotoLibrary: Bool = false
    @Published var pickedImages: [ImageAsset] = []
    @Published var rate: Int = 0
    
    
    init(shop: Shop) {
        self.shop = shop
    }
    
    func setRate(index: Int) {
        rate = index
    }
    
    func pickImages(selectedImages: [ImageAsset]) {
        pickedImages = selectedImages
    }
    
    func removeImage(index: Int) {
        pickedImages.remove(at: index)
        pickedImages.enumerated().forEach { item in
            pickedImages[item.offset].assetIndex = item.offset
        }
    }
    
    func postReview() { //TODO: 리뷰 보낸 후 메인 페이지로.
        print(shop.shopID)
        ReviewRepository.postReview(content: content, rate: rate, reviewImages: pickedImages, shopID: shop.shopID) { result in
            switch(result) {
            case .success(let value):
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
