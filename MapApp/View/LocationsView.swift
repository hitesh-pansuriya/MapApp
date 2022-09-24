//
//  LocationsView.swift
//  MapApp
//
//  Created by PC on 16/09/22.
//

import SwiftUI
import MapKit


struct LocationsView: View {

    @EnvironmentObject private var vm : LocationsVieModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()

            VStack(spacing:0){
                header
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()

                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsVieModel())
    }
}

extension LocationsView{

    private var header: some View{
        VStack {
            Button(action: vm.toggleLocationsList){
                Text(vm.mapLoaction.name + ", " + vm.mapLoaction.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLoaction)
                    .overlay(alignment: .leading, content: {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    })

            }
            if vm.showLocationsList{
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()

    }

    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotionView()
                    .scaleEffect(
                        vm.mapLoaction == location ? 1 : 0.7
                    )
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLoction(location: location)
                    }
            }
        })
    }

    private var locationsPreviewStack: some View {
        ZStack{
            ForEach(vm.locations){ location in

                if vm.mapLoaction == location{
                    LocationPreView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading) ))
                }
            }
        }
    }
}
