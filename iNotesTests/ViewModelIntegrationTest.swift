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

}
