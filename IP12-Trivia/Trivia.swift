//
//  Trivia.swift
//  IP12-Trivia
//
//  Created by Gopez, Ethan A on 1/23/24.
//

import Foundation

public class Trivia {
    var question : String
    var answer : String
    var fakes : [String]
    
    init(q: String, correct:String , incorrect: [String]) {
        question = q
        answer = correct
        fakes = incorrect
    }
    
    func equals(_ other : Trivia) -> Bool {
        return question == other.question
    }
}


