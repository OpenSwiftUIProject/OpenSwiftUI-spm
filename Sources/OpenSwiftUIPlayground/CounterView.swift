//
//  CounterView.swift
//  OpenSwiftUIPlayground

import OpenObservation
import OpenSwiftUI

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
@Observable
private final class Model {
    var count = 0
    @ObservationIgnored var step = 1

    func increment() {
        count += step
    }
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
struct CounterView: View {
    @State private var counter = Model()
    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            // TODO: Button
            Text("Increment")
                .onTapGesture {
                    counter.increment()
                }
        }
    }
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
#Preview {
    CounterView()
}
