//
//  ScoreViewController.swift
//  Dummy
//
//  Created by Bryan Oppong-Boateng on 11.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    var correctnessPercentage: Double
    
    init(with correctnessPercentage: Double) {
        self.correctnessPercentage = correctnessPercentage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color(for: correctnessPercentage)
        

        let headlineLabel = UILabel()
        headlineLabel.text = "SCORE"
        headlineLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)

        let correctnessPercentageLabel = UILabel()
        correctnessPercentageLabel.text = "\(String(format: "%.0f", correctnessPercentage * 100))%"
        correctnessPercentageLabel.font = UIFont.systemFont(ofSize: 80, weight: .bold)

        let correctnessLabel = UILabel()
        correctnessLabel.text = "CORRECTNESS"
        correctnessLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        let innerStack = UIStackView()
        innerStack.alignment = .center
        innerStack.axis = .vertical
        innerStack.spacing = 8
        
        innerStack.addArrangedSubview(headlineLabel)
        innerStack.addArrangedSubview(correctnessPercentageLabel)
        innerStack.addArrangedSubview(correctnessLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Run Playground to start a new game"
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)

        
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 30


        stack.addArrangedSubview(innerStack)
        stack.addArrangedSubview(subtitleLabel)

        view.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func color(for percentage: Double) -> UIColor? {
        switch percentage {
        case 0...0.5:
            return .systemRed
        case 0.5...0.65:
            return .systemOrange
        case 0.65...0.8:
            return .systemYellow
        case 0.8...1:
            return .systemGreen
        default:
            return nil
        }
    }
}
