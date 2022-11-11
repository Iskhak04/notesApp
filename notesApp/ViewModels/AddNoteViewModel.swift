//
//  AddNoteViewModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class AddNoteViewModel: NSObject {
    
    let bag = DisposeBag()
    
    let model = AddNoteModel()
    
    var noteToAddVM = PublishSubject<String>()
    
    override init() {
        super.init()
        
        noteToAddVM.subscribe(onNext: {
            self.model.noteToAddM.onNext($0)
        }).disposed(by: bag)
    }
}
