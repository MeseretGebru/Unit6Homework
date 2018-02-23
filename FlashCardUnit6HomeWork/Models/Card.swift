//
//  Card.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

class Card {
    var ref: DatabaseReference?
    var key: String?
    var catKey: String?
    let question: String?
    let answer: String?
    
    // To convert TextFields into Category Model
    //
    init(ref: DatabaseReference?, catKey: String?, question: String?, answer: String?) {
        self.ref = ref
        self.key = ref?.key
        self.catKey = catKey
        self.question = question
        self.answer = answer
    }
    
    // to read from firebase
    init(snapShot: DataSnapshot){
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.key = value?["key"] as? String ?? ""
        self.catKey = value?["catKey"] as? String ?? ""
        self.question = value?["question"] as? String ?? ""
        self.answer = value?["answer"] as? String ?? ""
    }
    
    
    // convert into a Dictionary = [String: Any]
    func toAnyObj() -> [String: Any] {
        return ["key": key ?? "", "catKey": catKey ?? "", "question": question ?? "", "answer": answer ?? ""]
    }
} 