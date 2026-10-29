import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: AppTab = .locations
    @State private var isTabBarCompact = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MainTabBar
            CustomTabBar
        }
    }
}

#Preview {
    MainTabView()
        .environment(LocationsViewModels())
}

extension MainTabView {
    
    private var MainTabBar: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "map.fill", value: .locations) {
                LocationsView(isTabBarCompact: $isTabBarCompact)
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            Tab("", systemImage: "heart", value: .favorites) {
                FavoritesView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            Tab("", systemImage: "gearshape", value: .settings) {
                SettingsView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
    }
    
    private var CustomTabBar: some View {
        HStack {
            Image(systemName: "map.fill")
                .frame(maxWidth: .infinity)
                .foregroundStyle(selectedTab == .locations ? .red : .primary)
                .onTapGesture { selectedTab = .locations }
            
            Image(systemName: "heart.fill")
                .frame(maxWidth: .infinity)
                .foregroundStyle(selectedTab == .favorites ? .red : .primary)
                .onTapGesture { selectedTab = .favorites }
            
            Image(systemName: "gearshape.fill")
                .frame(maxWidth: .infinity)
                .foregroundStyle(selectedTab == .settings ? .red : .primary)
                .onTapGesture { selectedTab = .settings }
        }
        .font(.title2)
        .frame(height: 65)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 40)
        .offset(y: isTabBarCompact ? 100 : 0)
    }
}

