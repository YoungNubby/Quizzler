//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var userAnswer : Bool = false
    var questionNumber : Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
        nextQuestion()
        //scoreLabel.text = "Score: 0"
        //it seems like somewhere along the road I missed where she sets the score to 0 at the begining. It kept saying its max capacity of 9999
        //I added this myself, it works =]
        //Score is default set as an Int equal to 0, it then gets translated into a string in the updateUI(func)
        //bare with me....
        //I should not need to edit this scoreLabel.text
        //however, my scoreLabel is only changed/updated currently in my nextQuestion(func) WHEN the question number is less then 12
        //Therefore, it must not register the first question with a label?
        //adding the nextQuestion(func) should present the app fresh, blank, as if it had just been restart (the function was sitting up here as a comment b/c the line of code that is right above it is supposedly the same thing as the nextQuestion(func), If my nextQuestion(func) solves the score: 0 problem, then this is not the case, and either the hoe was lying, or more likely I got mixed up along the way.)
        //lets test this nextQuestion(fun) update score
        //else, editing the scoreLabel.text = "0" solves the problem
        //nextQuestion(func) solves the problem, I do not know why the line above it does not do the trick. Not currently going to look for where this information was discussed.
        //well shit... the score doesnt restart when the quiz does. She might be getting to this later.
        //update* she does =]
        //lol my current state vs CYOA emmotions
        //mini challenge= restart score
        //note* there are multiple ways to solve a problem, some might not always be the "right" way or the "conventional" way
        //would my scoreLabel.text edit do the trick?
        //update* no, it does not solve our problem, lets remove it before it gets lost
        //so, my next idea is instead of working in this workspace I believe to be the apps home screen, I am going to look at where/when the restart function gets called.
        //update* I am going to try putting the scoreLabel.text edit inside of the start over function, in hopes that it relabels our score to 0 when the start over function is called
        //question* at this point of restart, the scoreLabel may not represent the true score. Would like to test this theory. Would restating the score variable solve any issues?
        //lol, my score label does appear to be reset on restart, however, answering the next question reinstates the current score that the user has
        //lets try restating our score variable
        //this does appear to work, can it be done without using our scoreLabel.tet line?
        //this does not solve the problem. The score is not displayed as 0 on question 1
        //with 2 lines of code, we have solved the problem. Is this the solution she uses?
        //update* she does it with 1 line, only score = 0, I had to add scoreLabel.text edit because I believe questionLabel.text = firstQuestion.questionText is not the complete nextQuestion(func) as it should be
        
    }


    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            userAnswer = true
        } else if sender.tag == 2 {
            userAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            print("The Quiz is Finished")
            
            //questionNumber = 0 will restart your quiz, wont give you message, infinite repeat.
            
            let alert = UIAlertController(title: "Awesome", message: "You've completed the quiz. Do you wish to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        
        
        if correctAnswer == userAnswer {
            ProgressHUD.showSuccess("Correct")
            print("Thats right foolio!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
            print("Try again dumbdumb")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
        scoreLabel.text = "Score: 0"
        score = 0
    }
    
}


//so, I will take a look at the startOver(func) here to try and fix my CYOA

//I think I am going to start making remix notes, if I were to remake this, what would I like to see added/changed
//Remix: I would like the HUD to finish its animation before going on to the next question
