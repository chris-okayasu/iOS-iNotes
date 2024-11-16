//
//  UpdateAndDeleteNoteView.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import SwiftUI

struct UpdateAndDeleteNoteView: View {
    var viewModel: ViewModel
    let id: UUID
    @State var title: String = ""
    @State var text: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("Text"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeNoteWith(id: id)
                dismiss()
            }, label: {
                Label("Delete Note", systemImage: "trash")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(BorderedButtonStyle())
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    viewModel.updateNoteWith(id: id, newTitle: title, newText: text)
                    dismiss()
                }label: {
                    Text("Save Note")
                        .bold()
                }
            }
        }
        .navigationTitle("Update Note")
    }
}

//#Preview {
//    NavigationStack {
//        UpdateAndDeleteNoteView(viewModel: .init(), id: .init(), title: "test", text: "test2")
//    }
//}
