//
//  UserService.swift
//  twitterclone
//
//  Created by Rose Neezar on 13/04/2021.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String,completion: @escaping(User) -> Void)  {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (result) in
            guard let dictionary = result.value as? [String: AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
           completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void)  {
        var users = [User]()
        REF_USERS.observe(.childAdded) { (result) in
            let uid = result.key
            guard let dictionary = result.value as? [String: AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return
        }
        REF_USER_FOLLOWING.child(currentUid).updateChildValues([uid: 1]) { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUid: 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completions: @escaping(DatabaseCompletion)) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        REF_USER_FOLLOWING.child(currentUser).child(uid).removeValue { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).child(currentUser).removeValue(completionBlock: completions)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return
        }
        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { (result) in
            
            completion(result.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping(UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { (result) in
            let follower = result.children.allObjects.count
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(following: following, followers: follower)
                completion(stats)
            }
        }
    }
}
 
