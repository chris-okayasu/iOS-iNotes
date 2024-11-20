//
//  ViewModelTest.swift
//  iNotesTests
//
//  Created by chris on 2024/11/16.
//

import XCTest
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


final class ViewModelTest: XCTestCase {
    var viewModel : ViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel(
            createNoteUseCase: CreateNoteUseCaseMock(),
            fetchAllNotesUseCase: FetchAllNoteUseCaseMock()
        )
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockDatabase = []
    }
    
    // new note is added to the array
    func testCreateNoteWith(){
        //Given
        let title = "title"
        let text = "text"
        
        //When
        viewModel.createNoteWith(title: title, text: text)
        
        //Then
        XCTAssertEqual(viewModel.notes.count, 1) // new value at array
        XCTAssertEqual(viewModel.notes.first?.title, title) // title is title
        XCTAssertEqual(viewModel.notes.first?.text, text) // text is text
    }
    
    // new note is added to the array
    func testCreateThreeNotesWith(){
        //Given
        let title1 = "title 1"
        let text1 = "text 1"
        
        let title2 = "title 2"
        let text2 = "text 2"
        
        let title3 = "title 3"
        let text3 = "text 3"
        
        //When
        viewModel.createNoteWith(title: title1, text: text1)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        //Then
        XCTAssertEqual(viewModel.notes.count, 3) // new value at array
        XCTAssertEqual(viewModel.notes.first?.title, title1)
        XCTAssertEqual(viewModel.notes.first?.text, text1)
        
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    func testUpdateNoteWith(){
        // Given
        let title = "title"
        let text = "text"
        
        let newTitle = "new title"
        let newText = "new text"
        
        viewModel.createNoteWith(title: title, text: text) // create a note
        
        // When
        if let id = viewModel.notes.first?.id {
            viewModel.updateNoteWith(id: id, newTitle: newTitle, newText: newText)
            // Then
            XCTAssertEqual(viewModel.notes.first?.id, id)
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
        } else {
            XCTFail("No note found")
        }
    }
    
    func testRemoveNoteWith(){
        // Given
        let title = "title"
        let text = "text"
        
        viewModel.createNoteWith(title: title, text: text)
        // When
        if let id = viewModel.notes.first?.id {
            // Then
            viewModel.removeNoteWith(id: id)
            XCTAssertNil(viewModel.notes.first)
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail("The note was not deleted")
        }
    }
}
