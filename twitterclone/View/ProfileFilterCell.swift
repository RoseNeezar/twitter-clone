//
//  ProfileFilterCell.swift
//  twitterclone
//
//  Created by Rose Neezar on 18/04/2021.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    //MARK: - Properties
    var options: ProfileFilterOptons! {
        didSet{
            titleLabel.text = options.description
        }
    }
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "HELLO"
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
