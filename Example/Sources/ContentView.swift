//
//  ContentView.swift
//  Example

import OpenSwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Text

            VStack(spacing: 6) {
                Text(verbatim: "OpenSwiftUI Example")
                    .font(.title)
                Text(verbatim: "Color & Shape & Image")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

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

#Preview {
    ContentView()
}
