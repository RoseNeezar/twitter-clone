//
//  CaptionTextView.swift
//  twitterclone
//
//  Created by Rose Neezar on 14/04/2021.
//

import UIKit

class CaptionTextView: UITextView {
    //MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What is happening?"
        return label
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top:topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}