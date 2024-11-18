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
    func updateWith(id: UUID, title: String, text: String) throws
    func removeWith(id: UUID) throws
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
    
    @MainActor
    func updateWith(id: UUID, title: String, text: String) throws {
        // Predicate
        let predicate = #Predicate<Note> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<Note>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        
        do{
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            updateNote.title = title
            updateNote.text = text
            try container.mainContext.save()
        } catch{
            print("Error updating note: \(error.localizedDescription)")
            throw DatabaseError.errorUpdate
        }
    }

    @MainActor
    func removeWith(id: UUID) throws {
        let predicate = #Predicate<Note> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<Note>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        do {
           guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorDelete
            }
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
            
        } catch {
            print("Error deleting note: \(error.localizedDescription)")
            throw DatabaseError.errorDelete
        }
    }
}
