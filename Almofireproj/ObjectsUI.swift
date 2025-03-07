import SwiftUI

struct ObjectsUI: View {
    @StateObject var objects = ObjectsMVVM() // Ensure ObjectsMVVM conforms to ObservableObject

    var body: some View {
        VStack {
            List(objects.objects) { object in
                VStack(alignment: .leading) {
                    Text(object.name)
                        .font(.headline)
                    Text(object.data?.color ?? "No color available") // Provide a fallback value
                        .foregroundColor(.gray)
                  Text(object.data?.capacityGB?.description ?? "")
                }
            }
        }
        .onAppear {
            objects.fetchObjects()
        }
        .refreshable {
          objects.fetchObjects()
        }
    }
}

#Preview {
    ObjectsUI()
}
