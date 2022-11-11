//
//  NoteDetailViewModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailViewModel: NSObject {
    
    let bag = DisposeBag()
    
    let model = NoteDetailModel()
    
    var noteToEditVM = PublishSubject<[String: String]>()
    var noteToDeleteVM = PublishSubject<String>()
    
    override init() {
        super.init()
        
        noteToEditVM.subscribe(onNext: {
            self.model.noteToEditM.onNext($0)
        }).disposed(by: bag)
        
        noteToDeleteVM.subscribe(onNext: {
            self.model.noteToDeleteM.onNext($0)
        }).disposed(by: bag)
    }
}
