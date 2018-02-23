//
//  Category.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

struct Category {
    var ref: DatabaseReference?
    var key: String?
    var name: String?
    
    // To convert TextFields into Category Model
    // let newCategory = Category(ref: dbRef, name: nameStr)
    init(ref: DatabaseReference?, name: String?) {
        self.ref = ref
        self.key = ref?.key
        self.name = name
    }
    
    // read data from Firebase
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.key = value?["key"] as? String ?? ""
        self.name = value?["name"] as? String ?? ""
    }
    
    // convert into a Dictionary = [String: Any]
    func toAnyObj() -> [String: Any] {
        return ["key": key ?? "", "name": name ?? ""]
    }
}


