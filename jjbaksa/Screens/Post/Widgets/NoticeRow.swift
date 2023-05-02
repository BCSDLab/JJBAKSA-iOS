//
//  NoticeRow.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import SwiftUI

struct NoticeRow: View {
    @State var isContentShow: Bool = false
    var post: Post
    var isPowerNotice: Bool {
        post.boardType == "POWER_NOTICE"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(isPowerNotice ? "[중요] \(post.title)" : post.title)
                    .frame(width: 279, alignment: .leading)
                    .size16Medium()
                
                Spacer()
                
                Image(systemName: isContentShow ? "chevron.up" : "chevron.down")
                    .onTapGesture {
                        self.isContentShow.toggle()
                    }
                    .size14Regular()
            }
            .padding(.bottom, 8)
            
            if isContentShow {
                Text(post.content)
                    .size14Regular()
                    .padding(.bottom, 8)
            }
            Text(post.createdAt)
                .size11Regular()
                .foregroundColor(.base)
        }
        .padding(.vertical, 12)
        .padding(.leading, isPowerNotice ? 37 : 24)
        .padding(.trailing, 29)
        .overlay(isPowerNotice ? powerNoticeHighlight() : nil, alignment: .leading)
        
        Divider()
            .padding(.horizontal, 16)
    }
}

func powerNoticeHighlight() -> some View {
    RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(Color.main)
                .frame(width: 7)
                .offset(x: 7 / 2)
                .clipped()
                .offset(x: 7 / 4)
                .frame(width: 7 / 2)
                .padding(.leading, 13)
}
