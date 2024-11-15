//
//  ContentView.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(value: note){
                        VStack(alignment: .leading){
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: [
        .init(title: "Hello", text: "World", createdAt: .now),
        .init(title: "SwiftUI", text: "Is Awesome", createdAt: .now),
        .init(title: "Swift", text: "Is Cool", createdAt: .now)
    ]))
}
