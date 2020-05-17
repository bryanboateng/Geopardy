import UIKit

class AnswerButton: UIButton {
    
    var isoCode: String? {
        didSet {
            if let safeIsoCode = isoCode {
                self.setTitle(AnswerButton.countryName(for: safeIsoCode), for: .normal)
            }
        }
    }

    class func setUpDesign(for button : AnswerButton) {
                
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        button.layer.cornerRadius = 5
        
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center

    }

    class func systemButton() -> AnswerButton {
        let button = AnswerButton.init(type: .system)
        setUpDesign(for: button)
        
        return button
    }
    
    class func countryName(for isoCode: String) -> String {
        guard let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: isoCode) else {
            fatalError("Country name was not found")
        }
        return name
    }
    
}
