//
//  MyReviewRow.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/17.
//

import SwiftUI

struct MyReviewRow: View {
    @State var isContentShow: Bool = false
    var review: Review
    var totalElement: Int
    var firstElementID: Int
    
    var body: some View { //TODO: 날짜가 다르더라도 같은 상점의 후기는 같은 공간에.
        if review.id == firstElementID {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("총 \(totalElement)개의 리뷰")
                        .size16Bold()
                        .foregroundColor(.main)
                        .padding(.bottom, 2)
                    
                    Text("마지막 작성일 \(review.createdAt[0] % 2000).\(review.createdAt[1] < 10 ? "0\(review.createdAt[1])" : "\(review.createdAt[1])").\(review.createdAt[2])")
                        .size10Regular()
                        .foregroundColor(.base)
                }
                .padding(.leading, 16)
                .padding(.top, 20)
                .padding(.bottom, 11)
                Spacer()
            }
        } else {
            Rectangle()
                .fill()
                .foregroundColor(.line)
                .frame(width: .infinity, height: 3)
        }
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(review.shopReviewResponse.placeName)
                    .size18Bold()
                    .padding(.trailing, 2)
                Text(review.shopReviewResponse.categoryName)
                    .size12Medium()
                    .foregroundColor(.base)
                    .frame(height: 20, alignment: .bottom)
                Spacer()
                
                Image(systemName: isContentShow ? "chevron.up" : "chevron.down")
                    .onTapGesture {
                        self.isContentShow.toggle()
                    }
                    .size14Regular()
                    .foregroundColor(.base)
            }
            .padding(.bottom, 10)
            
            if isContentShow {
                VStack(alignment: .leading, spacing: 0) {
                    Text(review.content)
                        .size14Regular()
                        .padding(.bottom, 5)
                    HStack(spacing: 0) {
                        Text("\(review.createdAt[1] < 10 ? "0\(review.createdAt[1])" : "\(review.createdAt[1])")/\(review.createdAt[2])")
                            .size14Regular()
                            .foregroundColor(.base)
                            .padding(.trailing, 5)
                        Text("|")
                            .size14Regular()
                            .foregroundColor(.base)
                            .padding(.trailing, 6)
                        Image(systemName: "star.fill")
                            .size12Regular()
                            .foregroundColor(.main)
                            .padding(.trailing, 2)
                        Text("\(review.rate).0")
                            .size14Regular()
                            .foregroundColor(.base)
                    }
                }
            }
        }
        .padding(.vertical, 11)
        .padding(.leading, 17)
        .padding(.trailing, 21)
    }
}


struct MyReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewRow(review: Review(id: 1, content: "이것은 리뷰다", createdAt: [2023, 4, 17, 4, 15, 40], rate: 1, reviewImages: [ReviewImageResponse(imageId: 1, imageUrl: "", originalName: "", path: "")], shopReviewResponse: ShopReviewResponse(id: 1, categoryName: "중식당", placeId: "1", placeName: "수신반점"), userReviewResponse: UserReviewResponse(id: 1, account: "ios", nickname: "ios")), totalElement: 1, firstElementID: 34)
    }
}
