import SwiftUI

struct LocationMapAnnotationView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .font(.headline)
                .frame(width: 35)
                .padding(6)
                .foregroundStyle(.white)
                .background(.accent)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .foregroundStyle(.accent)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -8)
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    LocationMapAnnotationView()
}
