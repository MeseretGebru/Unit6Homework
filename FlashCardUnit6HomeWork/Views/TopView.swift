//
//  TopView.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TopView: UIView {

    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Question Question Question Question "
        label.textAlignment = .center
        return label
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
         addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addConstraints(){
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).multipliedBy(0.50)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
        }
        
    }
    
    

}
