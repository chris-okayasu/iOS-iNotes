//
//  CreateNoteView.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    @State var title: String = ""
    @State var text: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("Text"), axis: .vertical)
                } footer: {
                    Text("*Title is Required")
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    }label: {
                        Text("Create Note")
                            .bold()
                    }
                }
            }
            .navigationTitle("Create Note")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
//
//#Preview {
//    CreateNoteView(viewModel: .init())
//}
