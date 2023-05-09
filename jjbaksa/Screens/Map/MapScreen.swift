//
//  MapScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/22.
//

import SwiftUI
import NMapsMap

struct MapScreen: View {
    @StateObject var viewModel: MapViewModel = MapViewModel()
    @State var zoom: Double = 15.0
    @State var gotoLocation: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                UIMapView((viewModel.userLocation?.longitude ?? 0, viewModel.userLocation?.latitude ?? 0), zoom, gotoLocation)
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                if gotoLocation {
                                    gotoLocation.toggle()
                                }
                            })
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack(spacing: 0) {
                    NavigationLink(destination: {EmptyView()}) {
                        ZStack {
                            Capsule()
                                .fill(Color.textSub.opacity(0.8))
                                .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                .frame(width: 343, height: 48)
                            HStack(spacing: 0) {
                                Text("검색어를 입력해주세요.")
                                    .size16Medium()
                                    .foregroundColor(.munan)
                                    .padding(.leading, 34)
                                
                                Spacer()
                                
                                Image(systemName: "magnifyingglass")
                                    .imageSize(18)
                                    .foregroundColor(.munan)
                                    .padding(.trailing, 37)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 11)
                    
                    HStack(spacing: 0) {
                        Button(action: {viewModel.isNearbyStoreShow.toggle()}) {
                            ZStack {
                                Capsule()
                                    .stroke(viewModel.isNearbyStoreShow ? Color.main : Color.base, style: StrokeStyle(lineWidth: 1))
                                    .background(Capsule().fill(Color.textSub.opacity(0.9))
                                    )
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                    .frame(width: 116, height: 30)
                                HStack(spacing: 0) {
                                    //TODO: 이미지 변경.
                                    Image(systemName: "fork.knife")
                                        .imageSize(15)
                                        .foregroundColor(viewModel.isNearbyStoreShow ? Color.main : Color.munan)
                                        .padding(.trailing, 5)
                                    Text("가까운 음식점")
                                        .size14Regular()
                                        .foregroundColor(viewModel.isNearbyStoreShow ? Color.main : Color.munan)
                                }
                            }
                        }
                        .padding(.trailing, 4)
                        
                        Button(action: {viewModel.isFriendStoreShow.toggle()}) {
                            ZStack {
                                Capsule()
                                    .stroke(viewModel.isFriendStoreShow ? Color.main : Color.base, style: StrokeStyle(lineWidth: 1))
                                    .background(Capsule().fill(Color.textSub.opacity(0.9))
                                    )
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                    .frame(width: 103, height: 30)
                                HStack(spacing: 0) {
                                    Image(systemName: "person.2.fill")
                                        .imageSize(15)
                                        .foregroundColor(viewModel.isFriendStoreShow ? Color.main : Color.munan)
                                        .padding(.trailing, 5)
                                    Text("친구 음식점")
                                        .size14Regular()
                                        .foregroundColor(viewModel.isFriendStoreShow ? Color.main : Color.munan)
                                }
                            }
                        }
                        .padding(.trailing, 4)
                        
                        Button(action: {viewModel.isBookMarkStoreShow.toggle() }) {
                            ZStack {
                                Capsule()
                                    .stroke(viewModel.isBookMarkStoreShow ? Color.main : Color.base, style: StrokeStyle(lineWidth: 1))
                                    .background(Capsule().fill(Color.textSub.opacity(0.9))
                                    )
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                    .frame(width: 113, height: 30)
                                HStack(spacing: 0) {
                                    Image(systemName: "bookmark.fill")
                                        .imageSize(15)
                                        .foregroundColor(viewModel.isBookMarkStoreShow ? Color.main : Color.munan)
                                        .padding(.trailing, 5)
                                    Text("북마크 음식점")
                                        .size14Regular()
                                        .foregroundColor(viewModel.isBookMarkStoreShow ? Color.main : Color.munan)
                                }
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Button(action: {
                            zoom += 1
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.textSub)
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.munan)
                            }
                            
                        }
                        .padding(.bottom, 8)
                        
                        Button(action: {
                            zoom -= 1
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.textSub)
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.munan)
                            }
                            
                        }
                        .padding(.bottom, 8)
                        
                        Button(action: {
                            if !gotoLocation {
                                gotoLocation.toggle()
                            }
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.textSub)
                                    .shadow(color: .textMain.opacity(0.1), radius: 12, x: 2, y: 3)
                                
                                Image(systemName: "scope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(gotoLocation ? .base : .main)
                            }
                            .frame(width: 48, height: 48)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 24)
                    .padding(.bottom, 24)
                }
            }
            .zIndex(1)
        }
        
    }
}


struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    var zoom: Double
    var gotoLocation: Bool
    let cameraPosition = NMFCameraPosition()

    init(_ coord: (Double, Double), _ zoom: Double, _ gotoLocation: Bool) {
        self.coord = coord
        self.zoom = zoom
        self.gotoLocation = gotoLocation
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        
        let locationOverlay = view.mapView.locationOverlay
        locationOverlay.location = NMGLatLng(lat: coord.1, lng: coord.0)
        locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
        locationOverlay.hidden = false
        locationOverlay.iconWidth = 20
        locationOverlay.iconHeight = 20
        print("location : \(coord)")
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
        Coordinator(coord, zoom, gotoLocation)
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let target = cameraPosition.target
        
        if gotoLocation {
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coord.1, lng: coord.0), zoomTo: zoom)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            uiView.mapView.moveCamera(cameraUpdate)
            
        } else {
            let cameraUpdate = NMFCameraUpdate(scrollTo: target, zoomTo: zoom)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            uiView.mapView.moveCamera(cameraUpdate)
        }
    }
    


    class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        var coord: (Double, Double)
        var zoom: Double
        var gotoLocation: Bool

        init(_ coord: (Double, Double), _ zoom: Double, _ gotoLocation: Bool) {
            self.coord = coord
            self.zoom = zoom
            self.gotoLocation = gotoLocation
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

