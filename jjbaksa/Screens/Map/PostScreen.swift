//
//  PostScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI
import RichEditorView

struct PostScreen: View {
    @State var post: String = ""
    @State private var htmlText = "<html><body><p>This is <i>some </i>description!</p>\n<br>\n</body></html>"
    @State private var isEditingRichText = false

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                //TODO: 뒤로가기 버튼 및 검색 버튼 추가
                Divider()
                    .padding(.horizontal, 16)
                
                ZStack {
                    VStack (spacing: 0) {
                        if isEditingRichText {
                            Text("Is editing...")
                        } else {
                            Text("Not editing...")
                        }
                        RichTextEditor(htmlText: $htmlText, isEditingRichText: $isEditingRichText)
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
                            
                            Button(action: { ()
                            }) { //TODO: RichTextEditor Tools
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
        .navigationBarBackButtonHidden(false)
    }
}

struct RichTextEditor: UIViewRepresentable {
    
    
    class Coordinator: RichEditorDelegate {
        
        var parent: RichTextEditor
        
        init(_ parent: RichTextEditor) {
            self.parent = parent
        }
        
        func richEditorTookFocus(_ editor: RichEditorView) {
            parent.isEditingRichText = true
        }
        
        
        func richEditorLostFocus(_ editor: RichEditorView) {
            parent.isEditingRichText = false
        }
        
        func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
            parent.htmlText = content
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    @Binding var htmlText: String
    @Binding var isEditingRichText: Bool
    
    func makeUIView(context: Context) -> RichEditorView {
        let editor = RichEditorView(frame: .zero)
        editor.html = htmlText
        editor.isScrollEnabled = false
        editor.delegate = context.coordinator
        
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        toolbar.options = RichEditorDefaultOption.all
        toolbar.editor = editor
        
        editor.inputAccessoryView = toolbar
        
        return editor
    }
    
    func updateUIView(_ uiView: RichEditorView, context: Context) {
    }
    
    func setStrike() {
        let editor = RichEditorView(frame: .zero)
        editor.strikethrough()
    }
}

struct PostScreen_Previews: PreviewProvider {
    static var previews: some View {
        PostScreen()
    }
}
