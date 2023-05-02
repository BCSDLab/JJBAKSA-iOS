//
//  MapScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/22.
//

import SwiftUI
//import NMapsMap

struct MapScreen: View {
    @State var coord: (Double, Double) = (127.96723316031301, 35.70068507556328)
    @State var zoom: Double = 6.0
    @State var searchText: String = ""
    var body: some View {
        EmptyView()
    }
    }
        /*
        VStack(spacing: 0) {
            ZStack {
                UIMapView(coord, zoom)
                        .edgesIgnoringSafeArea(.vertical)
                VStack(spacing: 0) {
                    ZStack {
                        TextField("검색어를 입력해주세요.", text: $searchText)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .font(.system(size: 12))
                                .foregroundColor(.base)
                                .padding(.leading, 10)
                        Button(action: { () }) {
                            Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textMain)
                                    .font(.system(size: 18))
                        }
                                .padding(.leading, 300)


                    }
                            .frame(width: 343, height: 30)
                            .background(Capsule().fill(Color.line))
                            .padding(.top, 10)

                    Spacer()

                    VStack(spacing: 0) {
                        Button(action: {
                            zoom -= 1
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                        .foregroundColor(.textSub)
                                Image(systemName: "minus.circle")
                                        .foregroundColor(.textMain)
                            }
                                    .font(.system(size: 26))
                        }
                        Button(action: {
                            zoom += 1
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                        .foregroundColor(.textSub)
                                Image(systemName: "plus.circle")
                                        .foregroundColor(.textMain)
                            }
                                    .font(.system(size: 26))
                        }
                        Button(action: { () }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                        .foregroundColor(.textSub)
                                Image(systemName: "line.3.horizontal.circle.fill")
                                        .foregroundColor(.textMain)
                            }
                                    .font(.system(size: 26))
                        }
                    }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 16)
                            .padding(.bottom, 21)
                }
            }
                    .zIndex(1)
        }
    }
}


struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    var zoom: Double

    init(_ coord: (Double, Double), _ zoom: Double) {
        self.coord = coord
        self.zoom = zoom
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.showScaleBar = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = zoom
        view.mapView.mapType = .basic
        view.mapView.isZoomGestureEnabled = true
        view.mapView.isRotateGestureEnabled = false
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: true)
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        view.mapView.addOptionDelegate(delegate: context.coordinator)
        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(coord, zoom)
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord, zoomTo: zoom)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
    }


    class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        var coord: (Double, Double)
        var zoom: Double

        init(_ coord: (Double, Double), _ zoom: Double) {
            self.coord = coord
            self.zoom = zoom
        }

        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {

        }

        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {

        }

        func mapViewOptionChanged(_ mapView: NMFMapView) {

        }


    }


}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
*/
