//
//  Quiz.swift
//
//  Created by Bryan Oppong-Boateng on 11.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import Foundation

protocol QuizDelegate {
    func changedQuestion()
    func updatedScore()
}

class Quiz {
    private static let countryData = loadCountryData()
    private let questions: [Question]
    
    var grades: [String : Grade] {
        didSet {
            delegate?.updatedScore()
        }
    }
        
    private var currentIndex: Int {
        didSet {
            delegate?.changedQuestion()
        }
    }
    
    var delegate: QuizDelegate?
    
    
    init() {
        var questionsTemp: [Question] = []
        
        let isoCodes = Array(Quiz.countryData.countries.keys)[0..<20]
        
        for isoCode in isoCodes {
            var incorrectAnswers = Quiz.getIncorrectAnswers(for: isoCode)
            incorrectAnswers.insert(isoCode)
            questionsTemp.append(Question(correctAnswer: isoCode, answers: incorrectAnswers))
        }
            
        grades = [:]
        currentIndex = 0
        questions = questionsTemp
    }
    
    
    var currentCountryGeometry: CountryGeometry{
        return Quiz.countryData.countries[currentQuestion.correctAnswer]!
    }
    
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    var correctAnswersCount: Int {
        return grades.values.filter{$0 == .correct}.count
    }
    
    var incorrectAnswersCount: Int {
        return grades.values.filter{$0 == .incorrect}.count
    }
    
    var answeredQuestionsCount: Int {
        return grades.values.count
    }
    
    var questionsCount: Int {
        return questions.count
    }
        
    func proceedToNextQuestion() {
        currentIndex += 1
    }
    
    private class func getIncorrectAnswers(for isoCode: IsoCode) -> Set<String>{
        var isoCodes = Set(countryData.countries.keys)
        isoCodes.remove(isoCode)
        
        let isoCodeArray = isoCodes.shuffled()
                

        var returnSet: Set<String> = []
        
        for i in 0..<3 {
           returnSet.insert(isoCodeArray[i])
        }
        
        return returnSet
    }

    private class func loadCountryData() -> CountryData {
        let directionsPath = Bundle.main.path(forResource: "CountryData", ofType: "json")!
        let url = URL(fileURLWithPath: directionsPath)
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        return try! decoder.decode(CountryData.self, from: data)
    }
}
