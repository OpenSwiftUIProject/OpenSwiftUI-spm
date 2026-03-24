import OpenSwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Text

            Text(verbatim: "OpenSwiftUI Example")
                .font(.title)
            Text(verbatim: "Hello, OpenSwiftUI!")
                .font(.body)
                .foregroundStyle(.secondary)

            // MARK: - Color

            HStack(spacing: 12) {
                Color.red
                    .frame(width: 60, height: 60)
                Color.green
                    .frame(width: 60, height: 60)
                Color.blue
                    .frame(width: 60, height: 60)
            }

            // MARK: - Shape

            HStack(spacing: 12) {
                Circle()
                    .fill(.orange)
                    .frame(width: 60, height: 60)
                Rectangle()
                    .fill(.purple)
                    .frame(width: 60, height: 60)
                RoundedRectangle(cornerRadius: 12)
                    .fill(.cyan)
                    .frame(width: 60, height: 60)
                Capsule()
                    .fill(.mint)
                    .frame(width: 80, height: 40)
            }

            // MARK: - Image

            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.orange)
        }
        .padding()
    }
}
