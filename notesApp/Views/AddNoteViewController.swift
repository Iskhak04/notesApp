//
//  AddNoteViewController.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private let viewModel = AddNoteViewModel()
    
    private lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.font = UIFont(name: "Arial", size: 30)
        return view
    }()
    
    private lazy var addNoteButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNoteButtonClicked))
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Note"
        navigationItem.rightBarButtonItem = addNoteButton
        layout()
        
    }
    
    @objc func addNoteButtonClicked() {
        if let text = noteTextView.text, !text.isEmpty {
            
            viewModel.noteToAddVM.onNext(text)

            showAlert(title: "Success", message: "Your note was successfully added!", isSuccessful: true)
        } else {
            showAlert(title: "Error", message: "The note should not be empty!", isSuccessful: false)
        }
    }
    
    private func showAlert(title: String, message: String, isSuccessful: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var okAction: UIAlertAction?
        
        if isSuccessful {
            okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            okAction = UIAlertAction(title: "OK", style: .cancel)
        }
        
        alert.addAction(okAction!)
        
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
