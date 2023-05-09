//
//  ImagePickerViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/09.
//

import Foundation
import PhotosUI

class ImagePickerViewModel: ObservableObject {
    @Published var fetchedImages: [ImageAsset] = []
    @Published var selectedImages: [ImageAsset] 
    
    
    init(pickedImages: [ImageAsset]) {
        
        selectedImages = pickedImages
        fetchImages()
    }
    
    func fetchImages() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        PHAsset.fetchAssets(with: .image, options: options).enumerateObjects { asset, _, _ in
            let imageAsset: ImageAsset = .init(asset: asset)
            self.fetchedImages.append(imageAsset)
        }
    }
    
    func addImage(imageAsset: ImageAsset) {
        var newAsset = imageAsset
        newAsset.assetIndex = selectedImages.count
        selectedImages.append(newAsset)
    }
    
    func removeImage(index: Int) {
        selectedImages.remove(at: index)
        selectedImages.enumerated().forEach { item in
            selectedImages[item.offset].assetIndex = item.offset
        }
    }
}
