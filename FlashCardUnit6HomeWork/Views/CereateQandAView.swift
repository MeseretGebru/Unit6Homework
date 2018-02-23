//
//  CereateQandAView.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CereateQandAView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QandACell.self, forCellReuseIdentifier: "QACell")
        return tableView
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
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
    
    
}

