//
//  WritingScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/01/01.
//

import SwiftUI
import UIKit

struct WritingScreen: View {
    @ObservedObject var viewModel: WritingViewModel
    
    init(storeName: String) {
        self.viewModel = WritingViewModel(storeName: storeName)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 25))
                        .foregroundColor((index <= viewModel.rate) ? .main : .line)
                        .onTapGesture() {
                            viewModel.setRate(index: index)
                        }
                }
            }
            .padding(.bottom, 30)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                .frame(height: 2)
                .foregroundColor(.base)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.main)
                        .frame(width: 31, height: 31)
                    Image(systemName: "plus")
                        .frame(width: 12, height: 12)
                        .foregroundColor(.main)
                }
                .onTapGesture() {
                    viewModel.isShowPhotoLibrary = true
                }
                .frame(height: 80)
                .padding(.leading, 32)
                .padding(.trailing, 16)
                
                if viewModel.imgArr.isEmpty {
                    VStack(spacing: 0) {
                        Text("사진 첨부")
                            .size16Regular()
                            .foregroundColor(.textMain)
                            .padding(.bottom, 4)
                        Text("최대 10장까지 첨부할 수 있어요!")
                            .size12Regular()
                            .foregroundColor(.munan)
                        
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.imgArr.indices) { index in
                                ZStack {
                                    Image(uiImage:viewModel.imgArr[index].image)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .padding(.trailing, 4)
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.textSub)
                                            .opacity(0.8)
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(.main)
                                    }
                                    .font(.system(size: 18))
                                    .onTapGesture() {
                                        viewModel.imgArr.remove(at: index)
                                    }
                                    .padding(.leading, 65)
                                    .padding(.bottom, 65)

                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer()
            }
            .padding(.bottom, 24)
            
            //ScrollView(showsIndicators: true) { //TODO: 스크롤이 꼭 필요한지 물어보기.
            TextEditor(text: $viewModel.content)
                .accentColor(.textMain)
                .padding(.horizontal, 24)
                .size16Regular()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            //}
        }
        .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, imgArray: $viewModel.imgArr)
        }
        .navigationBarBackButtonHidden(false)
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

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
