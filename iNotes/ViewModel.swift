//
//  ViewModel.swift
//  iNotes
//
//  Created by chris on 2024/11/15.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    var databaseError: DatabaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesUseCaseProtocol
    var updateNoteWithUseCase: UpdateNoteUseCaseProtocol
    var removeNoteWithUseCase: RemoveNoteUseCaseProtocol
    
    init(notes: [Note] = [] ,
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesUseCaseProtocol = FetchAllNotesUseCase(),
         updateNoteWithUseCase: UpdateNoteUseCaseProtocol = UpdateNoteUseCase(),
         removeNoteWithUseCase: RemoveNoteUseCaseProtocol = RemoveNoteUseCase())
    {
        
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.updateNoteWithUseCase = updateNoteWithUseCase
        self.removeNoteWithUseCase = removeNoteWithUseCase
        fetchAllNotes()
        
    }
    
    func createNoteWith(title: String, text: String){

        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
             fetchAllNotes()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes(){
        do {
            notes = try fetchAllNotesUseCase.FetchAll()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // update a note by UUID
    func updateNoteWith(id: UUID, newTitle: String, newText: String){
        if let _ = notes.firstIndex(where: {$0.id == id}){
            do {
                try updateNoteWithUseCase.updateNoteWith(id: id, title: newTitle, text: newText)
                fetchAllNotes()
            } catch {
              print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func removeNoteWith(id: UUID){
        do {
            try removeNoteWithUseCase.removeNoteWith(id: id)
            fetchAllNotes()
        } catch let error as DatabaseError {
          print ("Error: \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
