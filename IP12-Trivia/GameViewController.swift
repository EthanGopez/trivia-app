//
//  GameViewController.swift
//  IP12-Trivia
//
//  Created by Gopez, Ethan A on 2/2/24.

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var qLabel: UILabel!
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var correctLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var gameState : Game!
    
    var currentQNum : Int!
    
    //var lastQuestionCorrect : Bool!
    
    var currentAnswers : [String]!
    
    var currentCorrectIndex : Int!

    var currentCorrectCount : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQNum = -1
        //lastQuestionCorrect = false
        currentCorrectIndex = -1
        currentCorrectCount = -1
    }
    
    //will create a new game using the other viewController's things
    override func viewWillAppear(_ animated: Bool) {
        print("game opened")
        
        
        let cat  = tabBarController!.viewControllers![0]
        
        if let c = cat as? MenuViewController {
            if let currentGame = gameState {
                if currentGame.isNewGame(questionCount: c.getCurrentCount(), category: c.getCurrentCategory()) {
                    startNewGame()
                }
            }
            else {
                startNewGame()
                print("first game")
            }
        }
        
        
        
        
    }
    
    
    /*
     things that must happen to start new game:
     1. correctLabel made blank
     2. currentQNUm = 1
     3. loadQuestion
     
     */
    func startNewGame() {
        print("new game started")
       
        
        let cat  = tabBarController!.viewControllers![0]
        
        if let c = cat as? MenuViewController {
            gameState = Game(questionCount: Int(c.getCurrentCount())!, category: c.getCurrentCategory())
        }
        
        correctLabel.text = ""
        currentQNum = 1
        currentCorrectCount = 0
        loadQuestion()
    }
    
    func loadQuestion() {
        guard let g = gameState else {
            print("you failed loading")
            return
        }
        
        g.loadNewQuestion()
        
        countLabel.text = "Question " + String(currentQNum) + "/" + String(g.questionCount)
        
        qLabel.text = g.getQuestion()
        
        currentAnswers = g.getAnswers()
        
        //sets button answers and currentCorrectNum based on answers[4]
        var i = 0
        for str in currentAnswers {
            if i != 4 {
                answerButtons[i].setTitle(str, for: .normal)
                i += 1
            }
            else {
                currentCorrectIndex = Int(str)
            }
        }
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
       
        
        guard let g = gameState else {
            print("you failed answerButtonPressed game state")
            return
        }
        
        //things to do if answer is correct
        if sender.tag == currentCorrectIndex {
            currentCorrectCount += 1
            correctLabel.text = "Question " + String(currentQNum) + " was correct!"
        }
        else { //things to do if the answer is wrong
            correctLabel.text = "Wrong, the answer was " + currentAnswers[currentCorrectIndex] + "."
        }
        
        //things to do always
        
        currentQNum += 1
        if g.questionCount < currentQNum {
            print("segue attempted")
            //start segue to do results
            performSegue(withIdentifier: "endgameSegue", sender: sender)
            
            //startNewGame() for when segue ends
            startNewGame()
            return
        }
        
        loadQuestion()
    }
    
//    @IBAction override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue ) {
        print("unwind completed")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let d = segue.destination as? ResultsViewController {
            d.loadView()
            d.setText( "Correct: " + String(currentCorrectCount) + "/" + String(currentQNum - 1))
            d.setVS(self)
        }
        
        //self.tabBarController!.selectedIndex = 0
    }
    
    

}
