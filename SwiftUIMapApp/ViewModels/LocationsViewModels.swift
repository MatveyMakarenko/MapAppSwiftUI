import Foundation
import SwiftUI
import MapKit

@Observable
final class LocationsViewModels {
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
    
    var savedFavoritesIds: [String] = UserDefaults.standard.stringArray(forKey: "saved_favorites") ?? []
    
    init() {
        let locations = LocationsDataService.locations
        
        self.locations = locations
        self.currentLocation = locations.first!

        for index in self.locations.indices {
            let id = self.locations[index].id
            self.locations[index].isFavorite = savedFavoritesIds.contains(id)
        }
        
        self.currentLocation = self.locations.first!
        self.updateMapRegion(location: currentLocation)
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
    
    func previousButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == currentLocation }) else { return }
        
        var previousIndex = (currentIndex - 1) % locations.count
        
        if previousIndex < 0 {
            previousIndex = locations.count - 1
        }
        print("Текущий индекс: \(currentIndex)")
        print("Предыдущий индекс: \(previousIndex)")
        
        
        updateNextLocation(location: locations[previousIndex])
    }
    
    func toggleFavorite(location: Location) {
        withAnimation(.easeInOut) {
            guard let index = locations.firstIndex(where: {
                $0.id == location.id
            }) else { return }
            
            if savedFavoritesIds.contains(location.id) {
                savedFavoritesIds.removeAll {
                    $0 == location.id
                }
            }
            else {
                savedFavoritesIds.append(location.id)
            }
            
            locations[index].isFavorite.toggle()
            currentLocation = locations[index]
            
            UserDefaults.standard.set(savedFavoritesIds, forKey: "saved_favorites")
        }
    }
}
