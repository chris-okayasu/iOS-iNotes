//
//  ViewModelIntegrationTest.swift
//  iNotesTests
//
//  Created by chris on 2024/11/16.
//

import XCTest
@testable import iNotes

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    // SUT -> System Under Test
    var sut: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let database = NotesDataBase.shared
        database.container = NotesDataBase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNotesUseCase: fetchAllNotesUseCase)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote(){
        // Given
        sut.createNoteWith(title: "test title", text: "test text")
        
        // When
        let note = sut.notes.first
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(sut.notes.count, 1)
        
        XCTAssertEqual(note?.title, "test title")
        XCTAssertEqual(note?.text, "test text")
    }
    
    func testCreateTwoNotes(){
        
        sut.createNoteWith(title: "test title", text: "test text")
        sut.createNoteWith(title: "test title 2", text: "test text 2")
        
        let firstNote = sut.notes.first
        let secondNote = sut.notes.last
        
        XCTAssertNotNil(firstNote)
        XCTAssertNotNil(secondNote)
        
        XCTAssertEqual(sut.notes.count, 2)
        
        XCTAssertEqual(firstNote?.title, "test title")
        XCTAssertEqual(firstNote?.text, "test text")
        
        XCTAssertEqual(secondNote?.title, "test title 2")
        XCTAssertEqual(secondNote?.text, "test text 2")
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "test title", text: "test text")
        sut.createNoteWith(title: "test title 2", text: "test text 2")
        
        // Then
        XCTAssertEqual(sut.notes.count, 2, "Should be 2 notes")
        
        let expectedNotes = [
            (title: "test title", text: "test text"),
            (title: "test title 2", text: "test text 2")
        ]
        
        for (index, note) in sut.notes.enumerated() {
            XCTAssertNotNil(note, "Note should not be nil at index \(index)")
            XCTAssertEqual(note.title, expectedNotes[index].title, "Title does not match at index \(index)")
            XCTAssertEqual(note.text, expectedNotes[index].text, "Text does not match at index \(index)")
        }
    }
    
    func testUpddateNote() {
        sut.createNoteWith(title: "test title", text: "test text")
        
        guard let note = sut.notes.first else {
            XCTFail("Should have a note")
            return
        }
        
        sut.updateNoteWith(id: note.id, newTitle: "new title 22", newText: "new text 33")
        sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sut.notes.first?.title, "new title 22", "Title does not match")
        XCTAssertEqual(sut.notes.first?.text, "new text 33", "Text does not match")
       
    }
    
    func testRemoveNote() {
        sut.createNoteWith(title: "test title 1", text: "test text 1")
        sut.createNoteWith(title: "test title 2", text: "test text 2")
        sut.createNoteWith(title: "test title 3", text: "test text 3")
        sut.createNoteWith(title: "test title 4", text: "test text 4")
        sut.createNoteWith(title: "test title 5", text: "test text 5")
        
        // Seleccionar la primera nota
        guard let noteToDelete = sut.notes.first else {
            XCTFail("Should have a note to delete")
            return
        }
        
        // Guardar valores de la nota a eliminar
        let noteID = noteToDelete.id
        let noteTitle = noteToDelete.title
        let noteText = noteToDelete.text
        
        sut.removeNoteWith(id: noteID)
        
        XCTAssertEqual(sut.notes.count, 4, "Should be 4 notes")
        
        XCTAssertFalse(sut.notes.contains(where: { $0.id == noteID }), "Note with the deleted ID should not exist")
        
        XCTAssertFalse(sut.notes.contains(where: { $0.title == noteTitle && $0.text == noteText }), "Note with the deleted content should not exist")
    }
    
    func testRemoveNoteInDataBaseThrowError() {
        sut.removeNoteWith(id: UUID())
        
        XCTAssertEqual(sut.notes.count, 0, "Should be 0 notes")
        
        XCTAssertNotNil(sut.databaseError)
        
        XCTAssertEqual(sut.databaseError, DatabaseError.errorDelete)
        
    }

}
