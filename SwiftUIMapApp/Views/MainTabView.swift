import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: AppTab = .locations
    
    var body: some View {
            TabView(selection: $selectedTab) {
                Tab("Map", systemImage: "map.fill", value: .locations) {
                    LocationsView()
                }
                Tab("Favorites",systemImage: "heart" ,value: .favorites) {
                    FavoritesView()
                }
                Tab("Settings", systemImage: "gearshape",value: .settings) {
                    SettingsView()
                }
                Tab("Profile", systemImage: "person.circle",value: .profile) {
                    Text(verbatim: "hello")
                }
            }
    }
}

#Preview {
    MainTabView()
        .environment(LocationsViewModels())
}
