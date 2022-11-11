//
//  NoteDetailViewController.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    private let viewModel = NoteDetailViewModel()
    
    lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.font = UIFont(name: "Arial", size: 30)
        return view
    }()
    
    var initialNote: String?
    
    private lazy var saveNoteButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNoteButtonClicked))
        
        return view
    }()
    
    private lazy var deleteNoteButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteNoteButtonClicked))
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Note"
        navigationItem.rightBarButtonItems = [saveNoteButton, deleteNoteButton]
        layout()
        
    }
    
    @objc func saveNoteButtonClicked() {
        if let text = noteTextView.text, !text.isEmpty {
            viewModel.noteToEditVM.onNext([initialNote!: noteTextView.text!])
            showAlert(title: "Success", message: "The note was saved successfully!", toDelete: false)
        } else {
            showAlert(title: "Error", message: "The note should note be empty!", toDelete: false)
        }
    }
    
    @objc func deleteNoteButtonClicked() {
        showAlert(title: "Delete confirm", message: "Are you sure you want to delete this note?", toDelete: true)
    }
    
    private func showAlert(title: String, message: String, toDelete: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if !toDelete {
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okAction)
        } else {
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.viewModel.noteToDeleteVM.onNext(self.initialNote!)
                
                let alrt = UIAlertController(title: "Success", message: "The note was deleted successfully!", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .cancel) { action in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alrt.addAction(ok)
                
                self.present(alrt, animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(10)
        }
    }
}
