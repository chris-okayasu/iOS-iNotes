//
//  Note.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import Foundation

struct Note: Identifiable, Hashable {
    let id: UUID
    let title: String
    let text: String?
    let createdAt: Date
    
    // get text if exist or empty string
    var getText: String {
        text ?? ""
    }
    // set a uuid each time a note is added since this is hashable
    init(id: UUID = UUID(), title: String, text: String? = nil, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.text = text
        self.createdAt = createdAt
    }
}
