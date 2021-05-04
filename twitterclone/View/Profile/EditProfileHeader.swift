//
//  EditProfileHeader.swift
//  twitterclone
//
//  Created by Rose Neezar on 04/05/2021.
//

import UIKit

class EditProfileHeader: UIView {
    //MARK: - Properties
    private let user: User
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
        backgroundColor = .twitterBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selector
}
