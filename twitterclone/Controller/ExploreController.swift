//
//  ExplorerController.swift
//  twitterclone
//
//  Created by Rose Neezar on 04/04/2021.
//

import UIKit

class ExploreController: UIViewController {
    //MARK: - Properties
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        configureUI()
    }
    

   //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
