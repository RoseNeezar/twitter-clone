//
//  UserService.swift
//  twitterclone
//
//  Created by Rose Neezar on 13/04/2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void)  {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (result) in
            guard let dictionary = result.value as? [String: AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
           completion(user)
        }
    }
}
