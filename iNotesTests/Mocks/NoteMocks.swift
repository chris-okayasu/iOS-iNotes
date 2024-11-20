//
//  CreateNoteUseCaseMock.swift
//  iNotesTests
//
//  Created by chris on 2024/11/20.
//

import Foundation
@testable import iNotes

var mockDatabase: [Note] = []

struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws  {
        let note = Note(title: title, text: text)
        mockDatabase.append(note)
    }
}

struct FetchAllNoteUseCaseMock: FetchAllNotesUseCaseProtocol {
    func FetchAll() throws -> [Note] {
        return mockDatabase
    }
}

struct UpdateNoteUseCaseMock: UpdateNoteUseCaseProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) throws  {
        if let index = mockDatabase.firstIndex(where: {$0.id == id}){
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}

struct RemoveNoteUseCaseMock: RemoveNoteUseCaseProtocol {
    func removeNoteWith(id: UUID) throws {
        if let index = mockDatabase.firstIndex(where: {$0.id == id}){
            mockDatabase.remove(at: index)
        }
    }
}
