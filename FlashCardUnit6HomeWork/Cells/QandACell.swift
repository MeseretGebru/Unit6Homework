//
//  QandACell.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class QandACell: UITableViewCell {

    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "question"
        label.textAlignment = .center
        return label
    }()
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "answer"
        label.textAlignment = .center
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupConstraints()
    }
    
    func configCell(qaCell: Card) {
        questionLabel.text = qaCell.question
        answerLabel.text = qaCell.answer
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(8)
            make.left.equalTo(snp.left).offset(8)
            make.right.equalTo(snp.right).offset(-8)
            //make.bottom.equalTo(answerLabel.snp.top).offset(8)
        }
        addSubview(answerLabel)
        answerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(8)
            make.right.equalTo(snp.right).offset(-8)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
    
}

