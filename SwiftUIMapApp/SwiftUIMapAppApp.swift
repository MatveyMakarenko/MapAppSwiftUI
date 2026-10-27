import SwiftUI

@main
struct SwiftUIMapAppApp: App {
    @State private var vm = LocationsViewModels()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(vm)
        }
    }
}
