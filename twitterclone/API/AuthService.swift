//
//  AuthService.swift
//  twitterclone
//
//  Created by Rose Neezar on 12/04/2021.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func loginUser(withEmail email:String,password:String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion )
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?,DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        let profileImage = credentials.profileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {
            return
        }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: error is \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl] as [String : Any]
                    
                    REF_USERS.child(uid).updateChildValues(values,withCompletionBlock: completion)
                }
            }
        }
    }
}
