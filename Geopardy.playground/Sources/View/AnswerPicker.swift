//
//  AnswerPicker.swift
//  Dummy
//
//  Created by Bryan Oppong-Boateng on 14.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import UIKit

class AnswerPicker: UIControl {
    
    private var answerButtons: [[AnswerButton]]
    
    var indexPathOfSelectedButton: IndexPath?
    
    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            
            for answerButton in answerButtons.joined() {
                answerButton.isEnabled = isEnabled
            }
        }
    }
    
    
    override init(frame: CGRect) {
        
        answerButtons = [[AnswerButton]]()
        for _ in 0..<2 {
            var row = [AnswerButton]()
            for _ in 0..<2 {
                row.append(AnswerButton.systemButton())
            }
            answerButtons.append(row)
        }
        
        
        let topSubStackView = UIStackView(arrangedSubviews: [answerButtons[0][0], answerButtons[0][1]])
        topSubStackView.distribution = .fillEqually
        topSubStackView.spacing = UIStackView.spacingUseSystem
        
        let bottomSubStackView = UIStackView(arrangedSubviews: [answerButtons[1][0], answerButtons[1][1]])
        bottomSubStackView.distribution = .fillEqually
        bottomSubStackView.spacing = UIStackView.spacingUseSystem
        
        
        let stackView = UIStackView(arrangedSubviews: [topSubStackView, bottomSubStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = UIStackView.spacingUseSystem

        super.init(frame: frame)
        
        answerButtons[0][0].addTarget(self, action: #selector(setIndexPathOfSelectedButton), for: .touchUpInside)
        answerButtons[0][1].addTarget(self, action: #selector(setIndexPathOfSelectedButton), for: .touchUpInside)
        answerButtons[1][0].addTarget(self, action: #selector(setIndexPathOfSelectedButton), for: .touchUpInside)
        answerButtons[1][1].addTarget(self, action: #selector(setIndexPathOfSelectedButton), for: .touchUpInside)
        
        addSubview(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indexPath(for button: AnswerButton) -> IndexPath? {
       for i in 0..<2 {
            for j in 0..<2 {
                let eif = answerButtons[i][j]
                if eif == button {
                    return IndexPath(row: i, section: j)
                }
            }
        }
        return nil
    }
    
    func indexPath(for isoCode: IsoCode) -> IndexPath?{
        for i in 0..<2 {
            for j in 0..<2 {
                let eif = answerButtons[i][j]
                if eif.isoCode == isoCode {
                    return IndexPath(row: i, section: j)
                }
            }
        }
        return nil
    }
    
    func button(at indexPath: IndexPath) -> AnswerButton{
        return answerButtons[indexPath.row][indexPath.section]
    }
    
    @objc private func setIndexPathOfSelectedButton(with sender: AnswerButton) {
        indexPathOfSelectedButton = indexPath(for: sender)
                
        sendActions(for: .valueChanged)
    }
}
