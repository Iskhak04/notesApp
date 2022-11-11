//
//  ViewController.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    var fetchedNotes: [Note] = []
    
    let bag = DisposeBag()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NoteCell.self, forCellWithReuseIdentifier: "NoteCell")
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var addNoteButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .orange
        view.tintColor = .white
        view.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)), for: .normal)
        view.layer.cornerRadius = 35
        view.addTarget(self, action: #selector(addNoteButtonClicked), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        navigationItem.title = "Notes App"
        viewModel.fetchedNotesVM.subscribe(onNext: {
            self.fetchedNotes = $0
        }).disposed(by: bag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.getNotesVM.onNext(true)
        notesCollectionView.reloadData()
    }
    
    @objc func addNoteButtonClicked() {
        let addNoteVC = AddNoteViewController()
        navigationController?.pushViewController(addNoteVC, animated: true)
    }

    private func layout() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(notesCollectionView)
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(0)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        view.addSubview(addNoteButton)
        addNoteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.backgroundColor = .cyan
        cell.noteText.text = fetchedNotes[indexPath.row].text
        cell.dateText.text = fetchedNotes[indexPath.row].date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.noteTextView.text = fetchedNotes[indexPath.row].text
        noteDetailVC.initialNote = fetchedNotes[indexPath.row].text
        
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
}
