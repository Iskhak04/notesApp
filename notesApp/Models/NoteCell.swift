//
//  NoteCell.swift
//  notesApp
//
//  Created by Iskhak Zhutanov on 11/11/22.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    var noteText: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        return view
    }()
    
    var dateText: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(noteText)
        noteText.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-26)
            make.left.equalTo(snp.left).offset(10)
        }
        
        addSubview(dateText)
        dateText.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-5)
            make.centerX.equalTo(snp.centerX).offset(0)
        }
    }
}
