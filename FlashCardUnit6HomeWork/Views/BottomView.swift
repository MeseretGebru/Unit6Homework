//
//  BottomView.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import DLRadioButton

class BottomView: UIView {
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Please choose the answer"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    lazy var resultDisplayLabel: UILabel = {
        let label = UILabel()
        label.text = "Correct / Wrong"
        label.layer.opacity = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    
    lazy var oneButton: DLRadioButton = {
        let button = DLRadioButton()
        return button
    }()
   
    lazy var twoButton: DLRadioButton = {
        let button = DLRadioButton()
        return button
    }()
    
    lazy var threeButton: DLRadioButton = {
        let button = DLRadioButton()
        return button
    }()
    
    // Labels StackView
    lazy var radioButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        //stackView.distribution = UIStackViewDistribution.fill
        stackView.semanticContentAttribute = .forceLeftToRight
        stackView.spacing = 10.0
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.backgroundColor = .blue
        addSubviews()
        addConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubviews(){
        addSubview(answerLabel)
        addSubview(resultDisplayLabel)
        addSubview(radioButtonStack)
        radioButtonStack.addArrangedSubview(oneButton)
        radioButtonStack.addArrangedSubview(twoButton)
        radioButtonStack.addArrangedSubview(threeButton)
    }
    
    func addConstraints(){
       
        answerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.centerX.equalTo(self.snp.centerX)
        }
        radioButtonStack.snp.makeConstraints { (stack) in
            stack.top.equalTo(answerLabel.snp.bottom).offset(32)
            stack.left.equalTo(snp.left).offset(8)
            stack.right.equalTo(snp.right).offset(-8)
            stack.bottom.equalTo(resultDisplayLabel.snp.top).offset(-32)
            
        }
        resultDisplayLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
        
    }
    
}
