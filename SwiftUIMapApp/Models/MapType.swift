import Foundation

enum MapType: String, CaseIterable, Identifiable {
    case standard = "Standard"
    case satellite = "Satellite"
    case hybrid = "Hybrid"
    
    var id: String {
        self.rawValue
    }
}
