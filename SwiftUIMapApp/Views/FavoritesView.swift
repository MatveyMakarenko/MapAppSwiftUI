import SwiftUI

struct FavoritesView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    
    var body: some View {
        NavigationStack {
            List(vm.locations.filter{ $0.isFavorite }) { location in
                VStack(alignment: .leading) {
                    Text(location.name)
                    Text(location.cityName)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environment(LocationsViewModels())
}
