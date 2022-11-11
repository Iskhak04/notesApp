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
            
            let currentDate = Date()
             
            // 1) Create a DateFormatter() object.
            let format = DateFormatter()
             
            // 2) Set the current timezone to .current, or America/Chicago.
            format.timeZone = .current
             
            // 3) Set the format of the altered date.
            format.dateFormat = "dd/MM/yyyy HH:mm"
             
            // 4) Set the current date, altered by timezone.
            let dateString = format.string(from: currentDate)
            
            newNote.date = dateString
            
            do {
                try self.context.save()
            } catch {
                fatalError("error adding note \(error.localizedDescription)")
            }
        }).disposed(by: bag)
    }
}
