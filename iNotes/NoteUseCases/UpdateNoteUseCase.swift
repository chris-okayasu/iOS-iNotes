//
//  UpdateNote.swift
//  iNotes
//
//  Created by chris on 2024/11/18.
//

import Foundation

protocol UpdateNoteUseCaseProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) throws
}

struct UpdateNoteUseCase: UpdateNoteUseCaseProtocol {
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNoteWith(id: UUID, title: String, text: String) throws  {
        try notesDatabase.updateWith(id: id, title: title, text: text)
    }
}
