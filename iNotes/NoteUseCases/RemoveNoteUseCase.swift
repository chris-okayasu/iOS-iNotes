//
//  RemoveNoteUseCase.swift
//  iNotes
//
//  Created by chris on 2024/11/18.
//

import Foundation

protocol RemoveNoteUseCaseProtocol {
    func removeNoteWith(id: UUID) throws
}

struct RemoveNoteUseCase: RemoveNoteUseCaseProtocol {
    
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNoteWith(id: UUID) throws {
        try notesDatabase.removeWith(id: id)
    }
    
}
