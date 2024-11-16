//
//  CreateNoteUseCase.swift
//  iNotes
//
//  Created by chris on 2024/11/16.
//

import Foundation

struct CreateNoteUseCase {
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(id: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.save(note: note)
    }
    
}
