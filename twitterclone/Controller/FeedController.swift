//
//  FeedController.swift
//  twitterclone
//
//  Created by Rose Neezar on 04/04/2021.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Properties
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        configureUI()
    }
    

   //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
