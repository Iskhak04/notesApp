//
//  HomeViewModel.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: NSObject {
    
    let model = HomeModel()
    
    let bag = DisposeBag()
    
    var getNotesVM = PublishSubject<Bool>()
    var fetchedNotesVM = PublishSubject<[Note]>()
    
    override init() {
        super.init()
        
        model.fetchedNotesM.subscribe(onNext: {
            self.fetchedNotesVM.onNext($0)
        }).disposed(by: bag)
        
        getNotesVM.subscribe(onNext: {
            self.model.getNotesM.onNext($0)
        }).disposed(by: bag)
        
    }
}
