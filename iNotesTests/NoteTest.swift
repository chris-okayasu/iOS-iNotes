//
//  iNotesTests.swift
//  iNotesTests
//
//  Created by chris on 2024/11/15.
//

import XCTest
@testable import iNotes

final class NoteTest: XCTestCase {
    
    func testNoteInitialization() {
        
        // Given or Arrange
        let title = "Hello, World!"
        let text = "This is a test note."
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then or Assert (what I am expecting)
        XCTAssertEqual(note.title, title, "title should be equal to \(title).")
        XCTAssertEqual(note.text, text, "text should be equal to \(text).")
        XCTAssertEqual(note.createdAt, date, "date should be equal to \(date).")
    }
    
    func testNoteTextIsEmpty() {
        
        // Given
        let title = "Hello, World!"
        let date = Date()
        
        // When
        let note = Note(title: title, text: nil, createdAt: date)
        
        // Then
        XCTAssertEqual(note.getText, "", "text should be empty. But it is \(note.getText).")
    }
    

    
    
    // failure example, it will never works...
    //    func testFailureExample() throws {
    //        XCTFail("Not yet implemented")
    //    }
    
}
