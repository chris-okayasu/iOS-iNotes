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
    @State var showCreateNote: Bool = false
    
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
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        showCreateNote.toggle()
                    }, label: {
                        Label("Create Note", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    })
                    .buttonStyle(.bordered)
                    .tint(.accentColor)
                    .bold()
                }
            }
            .navigationTitle("iNotes")
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: viewModel)
            })
            
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
