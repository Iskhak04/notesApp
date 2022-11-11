//
//  NoteDetailModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class NoteDetailModel: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let bag = DisposeBag()
    
    var noteToEditM = PublishSubject<[String: String]>()
    var noteToDeleteM = PublishSubject<String>()
    
    override init() {
        super.init()
        
        noteToEditM.subscribe(onNext: {
            let newNoteText = $0.first?.value
            let oldNoteText = $0.first?.key
            var fetchedNotes: [Note] = []
            
            do {
                fetchedNotes = try self.context.fetch(Note.fetchRequest())
                
                let indexOfNoteToEdit = fetchedNotes.firstIndex { note in
                    if note.text == oldNoteText {
                        return true
                    }
                    
                    return false
                }
                
                fetchedNotes[indexOfNoteToEdit!].text = newNoteText
                
                try self.context.save()
            } catch let error {
                fatalError("error fetching notes \(error.localizedDescription)")
            }
        }).disposed(by: bag)
        
        noteToDeleteM.subscribe(onNext: {
            let noteToDelete = $0
            var fetchedNotes: [Note] = []
            
            do {
                fetchedNotes = try self.context.fetch(Note.fetchRequest())
                
                let indexOfNoteToDelete = fetchedNotes.firstIndex { note in
                    if note.text == noteToDelete {
                        return true
                    }
                    
                    return false
                }
                
                self.context.delete(fetchedNotes[indexOfNoteToDelete!])
                
                try self.context.save()
            } catch let error {
                fatalError("error fetching notes \(error.localizedDescription)")
            }
        }).disposed(by: bag)
    }
}
