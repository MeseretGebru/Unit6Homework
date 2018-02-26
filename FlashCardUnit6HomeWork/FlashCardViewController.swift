//
//  FlashCardViewController.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct RandomAnswer {
    let answer: String
    let isTrue: Bool
}

class FlashCardViewController: UIViewController {

    let topView = TopView()
    let bottomView = BottomView()
    var ref: DatabaseReference!
    var selectedQuestion: Card! {
        didSet {
            topView.questionLabel.text = selectedQuestion.question
        }
    }
    var randomAnswer = [RandomAnswer]()
    var questionAnswer = [Card]() {
        didSet {
            displayRandomQuestion()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navSetup()
        viewContraints()
        topView.backgroundColor = .yellow
        bottomView.backgroundColor = .red
        ref = Database.database().reference()
        selectedButton()
        loadDataFromFirebase()
       
    }
    func navSetup(){
        navigationItem.title = "Questions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "play-button "), style: .plain, target: self, action: #selector(displayRandomQuestion))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayRandomQuestion()
    }
    
    private func loadDataFromFirebase() {
        
        ref?.child("Cards").observe(.value) { (snapShot) in
            var qa = [Card]()
            for child in snapShot.children {
                let newQA = Card(snapShot: child as! DataSnapshot)
                
                //if newQA.key == self.questionAnswer[0].key
                qa.append(newQA)
//}
                self.questionAnswer = qa
                
            }
        }
    }

    
    private func viewContraints() {
        view.addSubview(topView)
        
        topView.backgroundColor = .yellow
        topView.snp.makeConstraints { (tView) in
            tView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            tView.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            tView.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            tView.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (bView) in
        bView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            bView.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            bView.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            bView.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
    }
    
    @objc func displayRandomQuestion(){
        bottomView.resultDisplayLabel.layer.opacity = 0
        bottomView.oneButton.isHidden = false
        bottomView.twoButton.isHidden = false
        bottomView.threeButton.isHidden = false
        //
        bottomView.oneButton.isSelected = false
        bottomView.twoButton.isSelected = false
        bottomView.threeButton.isSelected = false
        if questionAnswer.count > 0 {
            selectedQuestion = questionAnswer[Int(arc4random() % UInt32(questionAnswer.count))]
            randomAnswer = []
            let correctAnswer = RandomAnswer(answer: selectedQuestion.answer!, isTrue: true)
            randomAnswer.append(correctAnswer)
            for _ in 0..<100 {
                let wrongAnswer = questionAnswer[Int(arc4random() % UInt32(questionAnswer.count))]
                if wrongAnswer.answer != correctAnswer.answer {
                    let newAnswer = RandomAnswer(answer: wrongAnswer.answer!, isTrue: false)
                    randomAnswer.append(newAnswer)
                }
                var cloneRandomAnswer = randomAnswer
                if randomAnswer.count == 3 {
                    let answerOne = cloneRandomAnswer.remove(at: Int(arc4random() % UInt32(cloneRandomAnswer.count)))
                    let answerTwo = cloneRandomAnswer.remove(at: Int(arc4random() % UInt32(cloneRandomAnswer.count)))
                    bottomView.oneButton.setTitle(answerOne.answer, for: .normal)
                    bottomView.twoButton.setTitle(answerTwo.answer, for: .normal)
                    bottomView.threeButton.setTitle(cloneRandomAnswer[0].answer, for: .normal)
                    break
                }
            }
        }
    }
    
    //For selectiong an answer....
    fileprivate func selectedButton() {
        
        // unselecting all the radiobuttons)
        bottomView.oneButton.isSelected = false
        bottomView.twoButton.isSelected = false
        bottomView.threeButton.isSelected = false
        
        //when a button is selected call the objective c function for each button
        bottomView.oneButton.addTarget(self, action: #selector(buttonOne), for: UIControlEvents.touchUpInside)
        bottomView.twoButton.addTarget(self, action: #selector(buttonTwo), for: UIControlEvents.touchUpInside)
        bottomView.threeButton.addTarget(self, action: #selector(buttonThree), for: UIControlEvents.touchUpInside)
    }
    
    private func isCorrect(answer: String?) {
        let correctA = randomAnswer.filter{$0.isTrue}.first!.answer
        if answer == correctA {
           
            bottomView.resultDisplayLabel.text = "YaY Correct!!!"
            print("Hey you got it!!!!!")
        } else {
             bottomView.resultDisplayLabel.text = "Wrong try again"
            print("Sorry you lost")
        }
        bottomView.oneButton.isHidden = true
        bottomView.twoButton.isHidden = true
        bottomView.threeButton.isHidden = true
    }
    
    @objc func buttonOne(){
        bottomView.twoButton.isSelected = false
        bottomView.threeButton.isSelected = false
        perform(#selector(flip), with: nil, afterDelay: 0.3)
        
        let choosenAnswer = bottomView.oneButton.titleLabel?.text
        isCorrect(answer: choosenAnswer)
        
    }
    
    @objc func buttonTwo(){
        perform(#selector(flip), with: nil, afterDelay: 0.3)
        
        let choosenAnswer = bottomView.twoButton.titleLabel?.text
        isCorrect(answer: choosenAnswer)
      
    }
    
    @objc func buttonThree(){
        perform(#selector(flip), with: nil, afterDelay: 0.3)
        let choosenAnswer = bottomView.threeButton.titleLabel?.text
        isCorrect(answer: choosenAnswer)
       
        
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        //        UIView.transition(with: topView, duration: 1.0, options: transitionOptions, animations: {
        //            self.topView.isHidden = true
        //        })
        
        UIView.transition(with: bottomView, duration: 1.0, options: transitionOptions, animations: {
            self.bottomView.isHidden = false
            UIView.animate(withDuration: 0.7, delay: 0.3, options: [.curveEaseIn], animations: {
//                self.bottomView.resultDisplayLabel.isHidden = true
                self.bottomView.resultDisplayLabel.layer.opacity = 1.0
                self.bottomView.resultDisplayLabel.font = UIFont.italicSystemFont(ofSize: 30)
                self.bottomView.resultDisplayLabel.setNeedsLayout()
            }, completion: nil)
        })
        
    }

   
}
