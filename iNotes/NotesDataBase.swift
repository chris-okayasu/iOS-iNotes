//
//  NotesDataBase.swift
//  iNotes
//
//  Created by chris on 2024/11/16.
//

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorSave
    case errorFetch
    case errorUpdate
    case errorDelete
}

protocol NotesDataBaseProtocol {
    func save(note: Note)  throws
    func fetchAll()  throws -> [Note]
//    func update(note: Note) throws
//    func delete(note: Note) throws
}

class NotesDataBase: NotesDataBaseProtocol {
    
    // singleton
    static let shared: NotesDataBase = NotesDataBase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init () {}
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
                container.mainContext.autosaveEnabled = true
            return container
            
        } catch {
            print("Error setting up container: \(error.localizedDescription)")
            fatalError("Database cannot be set up")
        }
    }
    @MainActor
    func save(note: Note) throws {
        container.mainContext.insert(note)
        do {
            try container.mainContext.save()
            
        } catch {
            print("Error saving note: \(error.localizedDescription)")
            throw DatabaseError.errorSave
        }
    }
    
    @MainActor
    func fetchAll() throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        do {
            let notes = try container.mainContext.fetch(fetchDescriptor)
            return notes
        } catch {
            print("Error fetching notes: \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
//    
//    @MainActor
//    func delete(note: Note) throws {
//        container.mainContext.delete(note)
//        do {
//            try container.mainContext.save()
//        } catch {
//            print("Error deleting note: \(error.localizedDescription)")
//            throw DatabaseError.errorDelete
//        }
//    }
}
