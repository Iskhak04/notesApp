//
//  HomeModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class HomeModel: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let bag = DisposeBag()
    
    var getNotesM = PublishSubject<Bool>()
    var fetchedNotesM = PublishSubject<[Note]>()
    
    override init() {
        super.init()
        
        getNotesM.subscribe(onNext: {
            if $0 {
                //fetching notes from NotesDB
                do {
                    self.fetchedNotesM.onNext(try self.context.fetch(Note.fetchRequest()))
                } catch {
                    fatalError("error fetching notes \(error.localizedDescription)")
                }
            }
        }).disposed(by: bag)
        
    }
}
