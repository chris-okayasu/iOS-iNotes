//
//  FetchAllNotesUseCase.swift
//  iNotes
//
//  Created by chris on 2024/11/16.
//

import Foundation
protocol FetchAllNotesUseCaseProtocol {
    func FetchAll() throws -> [Note]
}

struct FetchAllNotesUseCase: FetchAllNotesUseCaseProtocol {
    var notesDatabase: NotesDataBaseProtocol
    
    init(notesDatabase: NotesDataBaseProtocol = NotesDataBase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func FetchAll() throws -> [Note] {
        try notesDatabase.fetchAll()
    }
    
}
