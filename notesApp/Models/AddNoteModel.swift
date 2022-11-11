//
//  AddNoteModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class AddNoteModel: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let bag = DisposeBag()
    
    var noteToAddM = PublishSubject<String>()
    
    override init() {
        super.init()
        
        noteToAddM.subscribe(onNext: {
            
            let newNote = Note(context: self.context)
            
            newNote.text = $0
            
            do {
                try self.context.save()
            } catch {
                fatalError("error adding note \(error.localizedDescription)")
            }
        }).disposed(by: bag)
    }
}
