import SwiftUI

struct SettingsView: View {
    @AppStorage("use_Kilometers") private var isKilometers: Bool = true
    @AppStorage("map_type") private var mapType: MapType = .standard

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Единица измерения") {
                        Toggle("Use kilometers", isOn: $isKilometers)
                    }
                
                Section("Отображение карты") {
                    Picker("Map type", selection: $mapType) {
                        ForEach(MapType.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                    }
            }
            
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
