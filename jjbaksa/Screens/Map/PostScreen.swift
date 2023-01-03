//
//  PostScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI

struct PostScreen: View {
    @State var post: String = ""
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                //TODO: 뒤로가기 버튼 및 검색 버튼 추가
                Divider()
                    .padding(.horizontal, 16)
                ZStack {
                    VStack (spacing: 0) {
                        //TODO: TextField Tappable area 수정
                        TextField("내용을 입력해주세요", text: $post)
                        
                            .font(.system(size: 12))
                            .padding(.top, 16)
                            .padding(.leading, 24)
                        Spacer()
                    }
                    VStack (spacing: 0) {
                        Spacer()
                        HStack (spacing: 0) {
                            Button(action: {()}) {
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.line)
                                    Image(systemName: "photo")
                                        .font(.system(size: 16))
                                        .foregroundColor(.textMain)
                                }
                            }.padding(.leading, 16)
                            
                            Button(action: {()}) {
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.line)
                                    Text("T")
                                        .font(.system(size: 24))
                                        .foregroundColor(.textMain)
                                }
                            }.padding(.leading, 8)
                            
                            Spacer()
                            
                            //TODO: 저장 버튼 Color 수정
                            Button(action: {()}) {
                                ZStack {
                                    Capsule()
                                        .frame(width: 54, height: 40)
                                        .foregroundColor(.base)
                                    Text("저장")
                                        .font(.system(size: 12))
                                        .foregroundColor(.textSub)
                                }
                            }.padding(.trailing, 16)
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PostScreen_Previews: PreviewProvider {
    static var previews: some View {
        PostScreen()
    }
}
