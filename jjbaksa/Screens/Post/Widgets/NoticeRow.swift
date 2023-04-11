//
//  NoticeRow.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import SwiftUI

struct NoticeRow: View {
    var post: Post

    var body: some View {
        VStack(spacing: 0) {
            if post.boardType == "POWER_NOTICE" {
                powerNoticeView(post: post)
                    .padding(.leading, 16)
                    .padding(.trailing, 24)
            } else {
                normalNoticeView(post: post)
                    .padding(.leading, 8)
                    .padding(.trailing, 24)

            }
            Divider()
                .padding(.horizontal, 16)
        }
    }
}

struct normalNoticeView: View {
    var post: Post
    @State var isContentShow: Bool = false
    var radius: CGFloat = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                
                Text(post.title)
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
        .padding(.vertical, 16)
        
        
    }
}

struct powerNoticeView: View {
    var post: Post
    @State var isContentShow: Bool = false
    var radius: CGFloat = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                
                Text("[중요] \(post.title)")
                    .frame(width: 274, alignment: .leading)
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
        .padding(.vertical, 16)
                .overlay(Rectangle().frame(width: 5, height: nil, alignment: .leading)
            .padding(.trailing, radius)
            .cornerRadius(radius)
            .padding(.leading, -16)
            .foregroundColor(.main), alignment: .leading)
    }
}


struct NoticeRow_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRow(post: Post(title: "공지사항", content: "테스트 내용", boardType: "POWER_NOTICE", createdAt: "2023-04-02"))
    }
}
