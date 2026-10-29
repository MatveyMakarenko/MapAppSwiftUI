import SwiftUI

struct LocationsListView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.updateNextLocation(location: location)
                } label: {
                    locationMenu(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    LocationsListView()
        .environment(LocationsViewModels())
}

extension LocationsListView {
    private func locationMenu(location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}
