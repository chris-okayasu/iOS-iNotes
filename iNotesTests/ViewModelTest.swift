//
//  ViewModelTest.swift
//  iNotesTests
//
//  Created by chris on 2024/11/16.
//

import XCTest
@testable import iNotes

final class ViewModelTest: XCTestCase {
    var viewModel : ViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
}
