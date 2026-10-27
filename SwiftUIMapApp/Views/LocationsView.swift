import SwiftUI
import MapKit

struct LocationsView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    
    var body: some View {
        @Bindable var vm = vm
        ZStack {
            Map(position: $vm.mapPosition) {
                ForEach(vm.locations) { location in
                    mapPin(location: location, isSelected: vm.currentLocation == location)
                }
            }
            
            VStack(spacing: 0) {
                header
                    .padding()
                    
                Spacer()
                
                LocationPreviewView(location: vm.currentLocation)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .id(vm.currentLocation.id)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                    .sheet(item: $vm.sheetLocation) { location in
                        LocationLearnMoreView(location: location)
                    }
            }
        }
    }
}

#Preview {
    let vm = LocationsViewModels()

        if let lastLocation = vm.locations.last {
            vm.updateNextLocation(location: lastLocation)
        }
    
    return LocationsView()
        .environment(vm)
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toggleListButton) {
                Text("\(vm.currentLocation.name), \(vm.currentLocation.cityName)")
                    .padding(.horizontal, 30)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapPosition)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal,15)
                            .rotationEffect(Angle.degrees(vm.toggleButton ? 180 : 0))
                    }
            }
            .foregroundStyle(.primary)

            if vm.toggleButton {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.3),radius: 10, x: 0, y: 10)
    }
    
    private func mapPin(
        location: Location,
        isSelected: Bool
    ) -> some MapContent {
        Annotation("", coordinate: location.coordinates) {
            LocationMapAnnotationView()
                .scaleEffect(isSelected ? 1.0 : 0.7)
                .onTapGesture {
                    vm.updateNextLocation(location: location)
                }
        }
    }
}
