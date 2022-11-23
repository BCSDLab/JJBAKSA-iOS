//
//  SignUpTermsView.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpTermsView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State var personalTerm: Bool = false
    @State var jjbaksaTerm: Bool = false
    @State var showPersonalTerm: Bool = false
    @State var showJjbaksaTerm: Bool = false
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action : {
                presentation.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.backward")
                    .size16Regular()
                    .foregroundColor(.base)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 0))
            
            Spacer()
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .sizeCustom(30)
                    .padding(.trailing, 7)
                Text("쩝쩝박사")
                    .size18Bold()
            }
            
            Text("약관동의")
                .size16Bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 48, leading: 75, bottom: 26, trailing: 0))
            
            VStack(spacing: 0) {
                HStack(spacing: 0){
                    Button(action: {personalTerm.toggle()} ) {
                        if personalTerm {
                            Image(systemName: "circle.fill")
                                .size16Regular()
                                .foregroundColor(.main)
                        } else {
                            Image(systemName: "circle")
                                .size16Regular()
                                .foregroundColor(.base)
                        }
                    }
                    .padding(.leading, 75)
                    .padding(.trailing, 8)
                    Text("개인정보 이용약관(필수)")
                        .size14Regular()
                        .padding(.trailing, 49)
                    Button(action: {showPersonalTerm.toggle()} ) {
                        if showPersonalTerm {
                            Image(systemName: "chevron.up")
                                .size14Regular()
                                .foregroundColor(.base)
                        } else {
                            Image(systemName: "chevron.down")
                                .size14Regular()
                                .foregroundColor(.base)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 24)
                
                HStack(spacing: 0){
                    if showPersonalTerm {
                        ScrollView {
                            Text(" 쩝쩝박사 서비스 이용약관은 bcsd lab에서 서비스를 제공함에 있어, 이용자간의 관리, 의무 및 책임 사항 등을 목적으로 합니다.\n\n 본 약관(이하 ‘본 약관’이라 함)은 쩝쩝박사 어플리케이션과 모바일 및 PC 포함 이와 관련된 웹사이트들(이하 ‘쩝쩝박사’라 함)을 통하여 제공되는 모든 제품 및 서비스(이하 ‘본 서비스’라 함)와 관련하여 본 약관에 따라 당사와 이용계약을 체결하고 본 서비스를 이용하는 고객(이하 ‘회원’이라 함)과 당사 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다. 당사에 회원가입을 하지 않고 단순 열람을 원하는 경우, 비회원 이용자를 위한 이용정책이 적용됩니다.")
                                .size12Regular()
                                .padding(10)
                        }
                        .frame(width: 226 ,height: 144)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.base))
                        .padding(.bottom, 10)
                    }
                }
                
                HStack(spacing: 0){
                    Button(action: {jjbaksaTerm.toggle()} ) {
                        if jjbaksaTerm {
                            Image(systemName: "circle.fill")
                                .size16Regular()
                                .foregroundColor(.main)
                        } else {
                            Image(systemName: "circle")
                                .size16Regular()
                                .foregroundColor(.base)
                        }
                    }
                    .padding(.leading, 75)
                    .padding(.trailing, 8)
                    Text("쩝쩝박사 이용약관(필수)")
                        .size14Regular()
                        .padding(.trailing, 49)
                    Button(action: {showJjbaksaTerm.toggle()} ) {
                        if showJjbaksaTerm {
                            Image(systemName: "chevron.up")
                                .size14Regular()
                                .foregroundColor(.base)
                        } else {
                            Image(systemName: "chevron.down")
                                .size14Regular()
                                .foregroundColor(.base)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 24)
                
                HStack(spacing: 0){
                    if showJjbaksaTerm {
                        ScrollView {
                            Text(" 쩝쩝박사 서비스 이용약관은 bcsd lab에서 서비스를 제공함에 있어, 이용자간의 관리, 의무 및 책임 사항 등을 목적으로 합니다.\n\n 본 약관(이하 ‘본 약관’이라 함)은 쩝쩝박사 어플리케이션과 모바일 및 PC 포함 이와 관련된 웹사이트들(이하 ‘쩝쩝박사’라 함)을 통하여 제공되는 모든 제품 및 서비스(이하 ‘본 서비스’라 함)와 관련하여 본 약관에 따라 당사와 이용계약을 체결하고 본 서비스를 이용하는 고객(이하 ‘회원’이라 함)과 당사 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다. 당사에 회원가입을 하지 않고 단순 열람을 원하는 경우, 비회원 이용자를 위한 이용정책이 적용됩니다.")
                                .size12Regular()
                                .padding(10)
                        }
                        .frame(width: 226 ,height: 144)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.base))
                    }
                }
                

            }
            .frame(height: 330, alignment: .top)
            .animation(.spring())
            
            HStack(spacing: 0){
                Button(action: {
                    if !personalTerm || !jjbaksaTerm {
                        personalTerm = true
                        jjbaksaTerm = true
                    } else {
                        personalTerm = false
                        jjbaksaTerm = false
                    }
                } ) {
                    if personalTerm && jjbaksaTerm {
                        Image(systemName: "circle.fill")
                            .size16Regular()
                            .foregroundColor(.main)
                    } else {
                        Image(systemName: "circle")
                            .size16Regular()
                            .foregroundColor(.base)
                    }
                }
                .padding(.trailing, 8)
                Text("전체동의")
                    .size14Regular()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 41)
            .padding(.leading, 75)
            
            if personalTerm && jjbaksaTerm {
                Button(action: {
                    viewModel.currentTab += 1
                }) {
                    Text("다음")
                        .frame(width: 227, height: 40)
                        .size14Regular()
                        .foregroundColor(.textSub)
                        .background(Capsule().fill(Color.main))
                }
            } else {
                Text("다음")
                    .frame(width: 227, height: 40)
                    .size14Regular()
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.base))
            }
            Spacer()
        }
    }
}

struct SignUpTermsView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTermsView()
            .environmentObject(SignUpViewModel())
    }
}
