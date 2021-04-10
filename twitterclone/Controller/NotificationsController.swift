//
//  NotificationsController.swift
//  twitterclone
//
//  Created by Rose Neezar on 04/04/2021.
//

import UIKit

class NotificationsController: UIViewController {
    //MARK: - Properties
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemTeal
        configureUI()
    }
    

   //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
}
