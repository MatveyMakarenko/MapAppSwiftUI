import SwiftUI

struct LocationPreviewView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    
    let location: Location
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                textSection
            }

            VStack(spacing: 20) {
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
        )
    }
        
}

#Preview {
    LocationPreviewView(location: LocationsDataService.locations.last!)
        .environment(LocationsViewModels())
        .padding()
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(8)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
    private var textSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .bold()
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
    }
    
    private var learnMoreButton: some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
