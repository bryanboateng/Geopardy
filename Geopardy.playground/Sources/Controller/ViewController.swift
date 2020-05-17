import UIKit

public class ViewController: UIViewController {
    
    let quiz = Quiz()
    
    private let answerPicker: AnswerPicker
    private let scoreView: ScoreView
    private var countryView: CountryView
    
    public init() {
        countryView = CountryView()
        answerPicker = AnswerPicker()
        scoreView = ScoreView()
                
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        quiz.delegate = self
        
        setUpGui()
    }
    
    func setUpGui() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let countryViewContainerView = UIView()
        countryViewContainerView.addSubview(countryView)
        countryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryView.trailingAnchor.constraint(equalTo: countryViewContainerView.trailingAnchor),
            countryView.leadingAnchor.constraint(equalTo: countryViewContainerView.leadingAnchor),
            countryView.centerYAnchor.constraint(equalTo: countryViewContainerView.centerYAnchor)
        ])
        
        stackView.addArrangedSubview(scoreView)
        stackView.addArrangedSubview(countryViewContainerView)
        answerPicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        answerPicker.addTarget(self, action: #selector(processAnswerSubmission), for: .valueChanged)
        stackView.addArrangedSubview(answerPicker)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        updateQuestionViews()
        updateScoreView()
    }
    
    @objc func processAnswerSubmission(_ sender: AnswerPicker) {
        
        let correctColor = UIColor.systemGreen
        let incorrectColor = UIColor.systemRed
        
        sender.isEnabled = false
        
        guard let indexPath = sender.indexPathOfSelectedButton else { return }
        let submittedButton = sender.button(at: indexPath)
        let submittedAnswer = submittedButton.isoCode!
                        
        if quiz.currentQuestion.check(answer: submittedAnswer) {
            quiz.grades[quiz.currentQuestion.correctAnswer] = .correct
            
            let beforeColor = submittedButton.backgroundColor
            submittedButton.backgroundColor = correctColor
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                submittedButton.backgroundColor = beforeColor
                sender.isEnabled = true
                self.advanceQuiz()
            }
        } else {
            quiz.grades[quiz.currentQuestion.correctAnswer] = .incorrect
                        
            let submittedButtonBeforeColor = submittedButton.backgroundColor
            submittedButton.backgroundColor = incorrectColor

            
            let correctAnswerIndexPath = answerPicker.indexPath(for: quiz.currentQuestion.correctAnswer)
            if let indexPath = correctAnswerIndexPath {
                
                let correctAnswerButton = answerPicker.button(at: indexPath)
                
                let correctAnswerButtonBeforeColor = correctAnswerButton.backgroundColor
                correctAnswerButton.backgroundColor = correctColor
                
                var runCount = 0
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                    correctAnswerButton.backgroundColor = correctAnswerButton.backgroundColor == correctAnswerButtonBeforeColor ? correctColor : correctAnswerButtonBeforeColor
                    
                    runCount += 1

                    if runCount == 7 {
                        timer.invalidate()
                        sender.isEnabled = true
                        submittedButton.backgroundColor = submittedButtonBeforeColor
                        self.advanceQuiz()
                    }
                }
            }
        }
    }
    
    func advanceQuiz() {
        if self.quiz.answeredQuestionsCount < self.quiz.questionsCount{
            self.quiz.proceedToNextQuestion()
        } else {
            let correctnessPercentage = (Double(self.quiz.correctAnswersCount) / Double(self.quiz.answeredQuestionsCount))

            let scoreViewController = EndViewController(with: correctnessPercentage)
            scoreViewController.isModalInPresentation = true

            self.present(scoreViewController, animated: true, completion: nil)
        }
    }
    
    func updateScoreView() {
        scoreView.correctCount = quiz.correctAnswersCount
        scoreView.incorrectCount = quiz.incorrectAnswersCount
        scoreView.totalCount = quiz.questionsCount
    }
    func updateQuestionViews() {
        let question = quiz.currentQuestion
        
        countryView.country = quiz.currentCountryGeometry
        
        let answerArray = Array(question.answers)
        
        answerPicker.button(at: IndexPath(row: 0, section: 0)).isoCode = answerArray[0]
        answerPicker.button(at: IndexPath(row: 0, section: 1)).isoCode = answerArray[1]
        answerPicker.button(at: IndexPath(row: 1, section: 0)).isoCode = answerArray[2]
        answerPicker.button(at: IndexPath(row: 1, section: 1)).isoCode = answerArray[3]
    }
}

extension ViewController: QuizDelegate {
    func changedQuestion() {
        updateQuestionViews()
    }
    
    func updatedScore() {
        updateScoreView()
    }
}
