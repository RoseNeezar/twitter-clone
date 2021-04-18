//
//  TweetService.swift
//  twitterclone
//
//  Created by Rose Neezar on 14/04/2021.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let values = [
            "uid":uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweets": 0,
            "caption": caption ] as [String : Any]
        let ref = REF_TWEETS.childByAutoId()
        
        ref.updateChildValues(values) { (err, ref) in
            guard let tweetID = ref.key else {return}
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID : 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void)  {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { (result) in
            guard let dictionary = result.value as? [String: AnyObject] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            let tweetID = result.key
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user,tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
          
        }
    }
    
    func fetchTweets(forUser user:User, completion: @escaping([Tweet])->Void) {
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { (result) in
            let tweetID = result.key
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { (snap) in
                guard let dictionary = snap.value as? [String: AnyObject] else {return}
                guard let uid = dictionary["uid"] as? String else {return}
                UserService.shared.fetchUser(uid: uid) { (user) in
                    let tweet = Tweet(user: user,tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        } withCancel: { (err) in
            print("DEBUG: Error \(err)")
        }

    }
}
