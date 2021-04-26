//
//  ActionSheetCell.swift
//  twitterclone
//
//  Created by Rose Neezar on 26/04/2021.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    // MARK: - Properties
    
    var option: ActionSheetOptions? {
        didSet{configure()}
    }
    
    private let optionImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "twitter_logo_blue")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test Options"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        optionImageView.setDimensions(width: 36, height: 36)
        
        let stack = UIStackView(arrangedSubviews: [optionImageView,titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor,paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    //MARK: Helpers
    
    func configure() {
        titleLabel.text = option?.description
    }
}
