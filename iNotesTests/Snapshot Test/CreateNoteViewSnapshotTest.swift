//
//  CreateNoteViewSnapshotTest.swift
//  iNotesTests
//
//  Created by chris on 2024/11/20.
//

import XCTest
import SnapshotTesting
@testable import iNotes

// UI TEST
final class CreateNoteViewSnapshotTest: XCTestCase {
    
    func testCreateNoteView() throws {
        let createNoteView = CreateNoteView(
            viewModel: .init()
        )
        assertSnapshot(
            of: createNoteView,
            as: .image
        )
       }
    
    func testCreateNoteView_WithText() throws {
        let createNoteView = CreateNoteView(
            viewModel: .init(),
            title: "Hello World",
            text: "This is a test"
        )
        assertSnapshot(
            of: createNoteView,
            as: .image
        )
    }

}
