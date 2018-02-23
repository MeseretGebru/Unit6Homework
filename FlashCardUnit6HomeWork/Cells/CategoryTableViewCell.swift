//
//  MainTableViewCell.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/21/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "test"
        label.textAlignment = .center
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupConstraints()
    }

    func configCell(cat: Category) {
        titleLabel.text = cat.name
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }

}
