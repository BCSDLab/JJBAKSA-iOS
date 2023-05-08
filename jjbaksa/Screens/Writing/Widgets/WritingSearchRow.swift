//
//  WritingSearchRow.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/04.
//

import SwiftUI

struct WritingSearchRow: View {
    var shop: Shop
    
    var body: some View {
        NavigationLink(destination: WritingScreen(storeName: shop.placeName) ) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 109, height: 65)
                    //.overlay()
                    
                        .padding(.trailing, 14)
                    VStack(alignment: .leading ,spacing: 0) {
                        HStack(spacing: 0) {
                            Text(shop.placeName)
                                .size18Bold()
                                .foregroundColor(.textMain)
                                .multilineTextAlignment(.trailing)
                            Text(shop.categoryName ?? "")
                                .size14Regular()
                                .foregroundColor(Color(hex: "#979797"))
                        }
                        .frame(height: 23)
                        .padding(.bottom, 4)
                        
                        HStack(spacing: 0) {
                            Text(shop.address ?? "")
                                .padding(.trailing, 4)
                                .multilineTextAlignment(.trailing)
                            Text("|")
                                .padding(.trailing, 4)
                            Text("\(String(format: "%.2f", (shop.dist ?? 0)))km")
                        }
                        .frame(height: 18)
                        .size14Regular()
                        .foregroundColor(.textMain)
                        .padding(.bottom, 2)
                        
                        HStack(spacing: 0) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.main)
                                .padding(.trailing, 2)
                            Text("\(String(format: "%.1f", (shop.score ?? 0)))")
                                .size14Medium()
                                .foregroundColor(.munan)
                                .padding(.trailing, 4)
                            Text("|")
                                .size14Regular()
                                .padding(.trailing, 4)
                            Text(shop.businessDay ?? "")
                                .size14Regular()
                                .foregroundColor(.red)
                        }
                        .frame(height: 18)
                    }
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.trailing, 8)
                .padding(.bottom, 16)
                .padding(.top, 8)
                Divider()
            }
        }
    }
}
