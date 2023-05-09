//
//  ImageAsset.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/08.
//

import SwiftUI
import PhotosUI

struct ImageAsset: Identifiable {
    var id: String = UUID().uuidString
    var asset: PHAsset
    var thumbnail: UIImage?
    var assetIndex: Int = -1
}
