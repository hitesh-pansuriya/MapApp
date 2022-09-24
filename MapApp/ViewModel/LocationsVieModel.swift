//
//  LocationsVieModel.swift
//  MapApp
//
//  Created by PC on 16/09/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationsVieModel: ObservableObject{
    // all loaded locations
    @Published  var locations = [Location]()

    //current location on map
    @Published  var mapLoaction: Location{
        didSet{
            updateMapRegion(location: mapLoaction)
        }
    }

    // Current region on map
    @Published  var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan =  MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    // shoe list of location
    @Published var showLocationsList: Bool = false

    // show location details via sheet
    @Published var sheetLocation: Location? = nil 

    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLoaction = locations.first!
        self.updateMapRegion(location: locations.first!)
    }

    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }

    public func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList = !showLocationsList
        }
    }

    func showNextLoction(location: Location){
        withAnimation(.easeInOut){
            mapLoaction = location
            showLocationsList = false
        }
    }

    func nextButtonPressed(){
        // get the current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLoaction} ) else{
            print("Could not find current index in location  array! should never happen.")
            return
        }

        // check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index is not  valid
            //Restart from 0
            guard let firstLocation = locations.first else {return}
            showNextLoction(location: firstLocation)
            return
        }

        //next index is valid
        let nextLocation = locations[nextIndex]
        showNextLoction(location: nextLocation)
    }
}
