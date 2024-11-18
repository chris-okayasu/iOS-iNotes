//
//  CreateNoteUseCase.swift
//  iNotes
//
//  Created by chris on 2024/11/16.
//

import Foundation
protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws
}
struct CreateNoteUseCase: CreateNoteProtocol {
    
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(id: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.save(note: note)
    }
    
}
