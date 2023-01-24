//
//  PostScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI
import UIKit
import RichEditorView

struct PostScreen: View {
    @State var post: String = ""
    @State var editorController: RichEditorView = RichEditorView(frame: .zero)
    @State var isShowTextToolBar: Bool = false
    @State var isShowPhotoLibrary: Bool = false
    @State var imgArr: [imageArray] = []
    //TODO: 변수명 변경 및 architecture 수정
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                //TODO: 뒤로가기 버튼 및 검색 버튼 추가
                Divider()
                        .padding(.horizontal, 16)

                ZStack {
                    VStack(spacing: 0) {
                        if !(imgArr.isEmpty) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(0..<imgArr.count, id:\.self) { idx in
                                        ZStack {
                                            Image(uiImage:imgArr[idx].image)
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .padding(8)
                                            
                                                .onTapGesture {
                                                    imgArr[idx].isImagePick.toggle()
                                                }
                                            if imgArr[idx].isImagePick {
                                                ZStack {
                                                    Button(action: {imgArr.remove(at: idx)}) {
                                                        Image(systemName: "trash.circle.fill")
                                                            .font(.system(size: 31))
                                                            .symbolRenderingMode(.palette)
                                                            .foregroundStyle(Color.main, Color.textSub)
                                                    }
                                                    Rectangle()
                                                        .frame(width: 80, height: 3)
                                                        .padding(.top, 77)
                                                        .foregroundColor(.main)
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        RichTextEditor(controller: $editorController)
                                .font(.system(size: 12))
                                .padding(.top, 16)
                                .padding(.leading, 24)

                        Spacer()
                    }

                    VStack(spacing: 0) {
                        Spacer()
                        HStack(spacing: 0) {
                            Button(action: { isShowPhotoLibrary = true }) {
                                ZStack {
                                    Circle()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.line)
                                    Image(systemName: "photo")
                                            .font(.system(size: 16))
                                            .foregroundColor(.textMain)
                                }
                            }
                            .padding(.leading, 16)
                            ZStack(alignment: .leading) {
                                ZStack {
                                    Capsule()
                                        .frame(width: isShowTextToolBar ? 137 : 40, height: 40)
                                        .foregroundColor(.base)
                                        .animation(.easeIn.speed(isShowTextToolBar ? 2.0 : 1.0), value: isShowTextToolBar)
                                    if isShowTextToolBar {
                                        HStack(spacing: 0) {
                                            Button(action: {
                                                editorController.setFontSize(16)
                                            }) {
                                                Text("H")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.textMain)
                                            }
                                            .padding(.trailing, 16)
                                            
                                            Button(action: {
                                                editorController.setFontSize(12)
                                            }) {
                                                Text("H")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.textMain)
                                            }
                                            .padding(.trailing, 16)
                                            
                                            Button(action: {
                                                editorController.strikethrough()
                                            }) {
                                                ZStack {
                                                    Image(systemName: "minus")
                                                        .font(.system(size: 15))
                                                    Text("T")
                                                        .font(.system(size: 18))
                                                        
                                                }
                                                
                                                .foregroundColor(.textMain)
                                            }
                                            .padding(.trailing, 16)
                                        }
                                        .padding(.leading, 56)
                                        .transition(.offset(x: isShowTextToolBar ? -24 : 0))
                                        .animation(.easeIn.speed(isShowTextToolBar ? 1.5 : 3.0))
                                    }
                                }
                                Button(action: {
                                    print(imgArr.count)
                                    isShowTextToolBar.toggle()
                                    //editorController.strikethrough()
                                }) { //TODO: RichTextEditor Tools
                                    ZStack {
                                        Circle()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.line)
                                        Text("T")
                                            .font(.system(size: 24))
                                            .foregroundColor(.textMain)
                                    }
                                }
                                
                            }
                            .padding(.leading, 8)
                            Spacer()

                            //TODO: 저장 버튼 Color 수정
                            Button(action: { () }) {
                                ZStack {
                                    Capsule()
                                            .frame(width: 54, height: 40)
                                            .foregroundColor(.base)
                                    Text("저장")
                                            .font(.system(size: 12))
                                            .foregroundColor(.textSub)
                                }
                            }
                                    .padding(.trailing, 16)
                        }
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, imgArray: $imgArr)
                    }
        }
                .navigationBarBackButtonHidden(false)
    }
}

struct RichTextEditor: UIViewRepresentable {
    @Binding var controller: RichEditorView

    class Coordinator: RichEditorDelegate {
        var parent: RichTextEditor

        init(_ parent: RichTextEditor) {
            self.parent = parent
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> RichEditorView {
        controller.isScrollEnabled = false
        controller.delegate = context.coordinator

        //let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        //toolbar.options = RichEditorDefaultOption.all
        //toolbar.editor = controller

        //controller.inputAccessoryView = toolbar

        return controller
    }

    func updateUIView(_ uiView: RichEditorView, context: Context) {
        uiView.html = controller.html
    }

}

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var imgArray: [imageArray]
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                var tmpArray = imageArray(image: image, isImagePick: false)
                
                parent.imgArray.append(tmpArray)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct imageArray {
    var image: UIImage
    var isImagePick: Bool
}

struct PostScreen_Previews: PreviewProvider {
    static var previews: some View {
        PostScreen()
    }
}
