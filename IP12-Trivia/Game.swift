//
//  Game.swift
//  IP12-Trivia
//
//  Created by Gopez, Ethan A on 1/31/24.
import Foundation

public class Game {
    let bank : [String : [Trivia]] = TriviaBank.getQuestions()
    var questionCount : Int
    var category : String
    var catBank : [Trivia]
    var currentQuestion : Trivia
    var answeredQuestions : [Trivia]
    var score : Int
    
    init(questionCount: Int, category: String) {
        self.questionCount = questionCount
        self.category = category
        self.catBank = bank[category]!
        currentQuestion = catBank[Int.random(in: 0..<catBank.count)]
        answeredQuestions = []
        score = 0
    }
    
    func isNewGame(questionCount: String, category: String) -> Bool {
        return questionCount != String(self.questionCount) || category != self.category
    }
    
    
    //generates new index for catBank
    //must be called for each new question in the GameViewController
    func loadNewQuestion() {
        repeat {
            currentQuestion = catBank[Int.random(in: 0..<catBank.count)]
        } while (contains(currentQuestion))
        
        answeredQuestions.append(currentQuestion)
        
        
    }
    
    private func contains(_ other : Trivia) -> Bool {
        for t in answeredQuestions {
            if other.equals(t) {
                return true
            }
        }
        
        return false
    }
    
    func getQuestion() -> String {
        return currentQuestion.question
    }
    
    
    //the fifth value in the returned collection is the correct answer value
    func getAnswers() -> [String] {
        var tempA : [String] = []
        var cPlace = Int.random(in: 0..<4)
        
        var i = 0
        for string in currentQuestion.fakes {
            if i == cPlace {
                tempA.append(currentQuestion.answer)
            }
            tempA.append(string)
            i += 1
        }
        
        if (cPlace == 3) {
            tempA.append(currentQuestion.answer)
        }
        
        tempA.append(String(cPlace))
        
        return tempA
    }
    
}
