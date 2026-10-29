import SwiftUI

struct FavoritesView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    @State private var selectedCity = "All"
    @State private var isTabBar = true
    @Binding var selectedTab: AppTab
    
    private let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
    
    var body: some View {
        NavigationStack {
    
            Group {
                if favoriteLocations.isEmpty {
                    ContentUnavailableView(
                        "No favorites",
                        systemImage: "heart.slash",
                        description: Text("Add places to favorites from the map")
                    )
                }
                else {
                    cityPicker
                    favoriteCards
                }
            }
            .padding()
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    @Previewable @State var selected: AppTab = .favorites
    FavoritesView(selectedTab: $selected)
        .environment(LocationsViewModels())
}



extension FavoritesView {
    
    private var favoriteLocations: [Location] {
        vm.locations.filter { $0.isFavorite }
    }
    
    private var cities: [String] {
        let cityNames = favoriteLocations.map { location in
            location.cityName
        }

        let uniqueCities = Array(Set(cityNames)).sorted()

        return ["All"] + uniqueCities
    }
    
    private var filteredLocations: [Location] {
        if selectedCity == "All" {
            return favoriteLocations
        }

        return favoriteLocations.filter { location in
            location.cityName == selectedCity
        }
    }
    
    private var cityPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(cities, id: \.self) { city in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedCity = city
                        }
                    } label: {
                        Text(city)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(
                                selectedCity == city ? .white : .primary
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 9)
                            .background {
                                Capsule()
                                    .fill(
                                        selectedCity == city
                                            ? Color.red
                                            : Color.gray.opacity(0.15)
                                    )
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func favoriteCard(location: Location) -> some View {
        VStack(alignment: .center, spacing: 8) {
            if let imageName = location.imageNames.first {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .overlay {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .center) {
                Group {
                    Text(location.name)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                       

                    Text(location.cityName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .frame(height: 20)
                }
                .frame(height: 43, alignment: .center)
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))

    }
    
    @ViewBuilder
    private func context(location: Location) -> some View {
        Button {
            selectedTab = .locations

            Task { @MainActor in
                try? await Task.sleep(for: .milliseconds(150))

                withAnimation(.easeInOut(duration: 0.5)) {
                    vm.currentLocation = location
                }
            }
        } label: {
            Label("Show on map", systemImage: "map")
        }
        Button {
//            <#code#>
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
        
        Button(role: .destructive) {
            vm.toggleFavorite(location: location)
        } label: {
            Label("Delete from favorites", systemImage: "star.slash")
        }
    }
    
    private var favoriteCards: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredLocations) { location in
                    favoriteCard(location: location)
                        .onTapGesture {
                            withAnimation {
                                vm.sheetLocation = location
                            }
                        }
                        .contextMenu {
                            context(location: location)
                        }

                }
            }
            .padding(.bottom, 70)
        }
    }
}
