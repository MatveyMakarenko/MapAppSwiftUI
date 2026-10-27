import SwiftUI

struct LocationPreviewView: View {
    @Environment(LocationsViewModels.self) private var vm: LocationsViewModels
    @State private var offset: CGSize = .zero
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                textSection
            }

            VStack(spacing: 15) {
                LikeButton
                    .fontWeight(.light)
                    .font(.title2)
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .padding(.top, 15)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
        )
        .offset(x: offset.width, y: 0)
        .gesture(drag)
    }
        
}

#Preview {
    LocationPreviewView(location: LocationsDataService.locations[1])
        .environment(LocationsViewModels())
        .padding()
}

extension LocationPreviewView {
    
    private var isFavorite: Bool {
        vm.locations.first(where: { $0.id == location.id })?.isFavorite == true
    }
    
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
    
    private var LikeButton: some View {
        Button {
            vm.toggleFavorite(location: vm.currentLocation)
        } label: {
            VStack {
                Image(systemName: isFavorite ? "star.fill" : "star")
            }
        }
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
            vm.previousButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged({ value in
                offset = value.translation
                
            })
            .onEnded({ value in
                withAnimation(.easeInOut) {
                if value.translation.width < -50 {
                    vm.nextButtonPressed()
                }
                else if value.translation.width > 50{
                    vm.previousButtonPressed()
                }
                    
                    offset = .zero
                }
            })
    }
}
