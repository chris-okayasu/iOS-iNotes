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
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
