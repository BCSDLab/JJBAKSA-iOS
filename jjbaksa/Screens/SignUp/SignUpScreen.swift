//
//  SignUpScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpScreen: View {
    @ObservedObject var viewModel = SignUpViewModel()

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            SignUpTermsView().tag(0).contentShape(Rectangle())
                    .gesture(DragGesture())
                    .environmentObject(viewModel)
            SignUpInfoView().tag(1).contentShape(Rectangle())
                    .gesture(DragGesture())
                    .environmentObject(viewModel)
            SignUpSuccessView().tag(2).contentShape(Rectangle())
                    .gesture(DragGesture())
        }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.default, value: viewModel.currentTab)
                .navigationBarBackButtonHidden(true)
    }
}

//just a dummy

class MySwipeGesture: UISwipeGestureRecognizer {

    @objc func noop() {
    }

    init(target: Any?) {
        super.init(target: target, action: #selector(noop))
    }
}

//this delegate effectively disables the gesure

class MySwipeGestureDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
}

//and the overlay inspired by the answer from the link above

struct TouchesHandler: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<TouchesHandler>) -> UIView {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(context.coordinator.makeGesture())
        return view;
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TouchesHandler>) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator {
        var delegate: UIGestureRecognizerDelegate = MySwipeGestureDelegate()

        func makeGesture() -> MySwipeGesture {
            delegate = MySwipeGestureDelegate()
            let gr = MySwipeGesture(target: self)
            gr.delegate = delegate
            return gr
        }
    }

    typealias UIViewType = UIView
}
