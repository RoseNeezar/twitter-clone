//
//  RegisterController.swift
//  twitterclone
//
//  Created by Rose Neezar on 10/04/2021.
//

import UIKit

class RegisterController:UIViewController {
    
    //MARK: - Properties
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        configureUI()
    }

    //MARK: - Selectors
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
   


    //MARK: - Helpers
    func configureUI()  {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}
