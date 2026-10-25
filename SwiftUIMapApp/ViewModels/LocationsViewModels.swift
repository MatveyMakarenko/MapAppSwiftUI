import Foundation
import SwiftUI
import MapKit

@Observable
class LocationsViewModels {
    var locations: [Location]
    
    var currentLocation: Location {
        didSet {
            updateMapRegion(location: currentLocation)
        }
    }
    
    var mapPosition: MapCameraPosition = .automatic
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    var toggleButton = false
    
    var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        mapPosition = .region(
            MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        )
    }
    
    func toggleListButton() {
        withAnimation(.easeInOut) {
            toggleButton.toggle()
        }
    }
    
    func updateNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            currentLocation = location
            toggleButton = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == currentLocation }) else { return }
        
        let nextIndex = (currentIndex + 1) % locations.count
        
        
        print("Текущий индекс: \(currentIndex)")
        print("Следующий индекс: \(nextIndex)")
        
            
        updateNextLocation(location: locations[nextIndex])
    }
}
