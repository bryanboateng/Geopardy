//
//  Question.swift
//
//  Created by Bryan Oppong-Boateng on 11.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import Foundation

struct Question {
    
    let correctAnswer: IsoCode
    let answers: Set<IsoCode>
    
    func check(answer: IsoCode) -> Bool {
       return answer == correctAnswer
    }
}
