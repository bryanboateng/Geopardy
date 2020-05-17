//
//  ScoreView.swift
//  Dummy
//
//  Created by Bryan Oppong-Boateng on 11.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import UIKit

class ScoreView: UIStackView {
    
    var correctCount: Int = 0 {
        didSet {
            updateLabelText()
        }
    }
    
    var incorrectCount: Int = 0 {
        didSet {
            updateLabelText()
        }
    }
    
    var totalCount: Int = 0 {
        didSet {
            updateLabelText()
        }
    }
    
    private let leftLabel: UILabel
    private let middleLabel: UILabel
    private let rightLabel: UILabel
    
    private func updateLabelText() {
        leftLabel.text = String(correctCount)
        
        middleLabel.text = String(incorrectCount)
        
        rightLabel.text = "\(correctCount + incorrectCount)/\(totalCount)"
    }

    override init(frame: CGRect) {
        
        let stackView = UIStackView()
        stackView.spacing = UIStackView.spacingUseSystem

        leftLabel = UILabel()
        leftLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        leftLabel.textColor = .systemGreen
        stackView.addArrangedSubview(leftLabel)
        
        
        middleLabel = UILabel()
        middleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        middleLabel.textColor = .systemRed
        stackView.addArrangedSubview(middleLabel)
        
        
        rightLabel = UILabel()
        rightLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        rightLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(rightLabel)

        super.init(frame: frame)
        
        axis = .vertical
        alignment = .trailing
        updateLabelText()
        
        addArrangedSubview(stackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
