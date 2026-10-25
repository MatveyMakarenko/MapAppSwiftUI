import SwiftUI
import MapKit

struct LocationLearnMoreView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .frame(height: 500)
            .tabViewStyle(.page)
            
            
            VStack {
                textSection
                
                Divider()
                
                descriptionSection
                
                Divider()
                
                mapLayer
                
            }
            .padding()
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LocationLearnMoreView(location: LocationsDataService.locations.first!)
        .environment(LocationsViewModels())
}

extension LocationLearnMoreView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal)
                    .frame(height: 500)
                    .clipped()
                    .overlay(backButton ,alignment: .topLeading)
            }
        }
    }
    
    private var textSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        @Bindable var vm = vm

        return Map(position: $vm.mapPosition) {
            Annotation("", coordinate: vm.currentLocation.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(
                            vm.currentLocation.id == location.id ? 1.0 : 0.7
                        )
                        .onTapGesture {
                            vm.updateNextLocation(location: location)
                        }
                }
            
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .padding(16)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(40)
        }
        .font(.headline)
        .foregroundStyle(.primary)

    }
    
}
