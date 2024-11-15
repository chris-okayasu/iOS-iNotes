//
//  ViewModel.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    // insert a new note to the array of notes
    func createNoteWith(title: String, text: String){
        let note: Note = .init(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    // update a note by UUID
    func updateNoteWith(id: UUID, newTitle: String, newText: String){
        if let index = notes.firstIndex(where: {$0.id == id}){
            let updateNote = Note(id: id, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updateNote
        }
    }
    func removeNoteWith(id: UUID){
        notes.removeAll(where: {$0.id == id})
    }
}
