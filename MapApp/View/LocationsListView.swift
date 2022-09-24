//
//  LocationsListView.swift
//  MapApp
//
//  Created by PC on 16/09/22.
//

import SwiftUI

struct LocationsListView: View {

    @EnvironmentObject private var vm : LocationsVieModel

    var body: some View {
        List{
            ForEach(vm.locations){ location in

                Button {
                    vm.showNextLoction(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsVieModel())
    }
}

extension LocationsListView{

    private func listRowView(location: Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }

            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
