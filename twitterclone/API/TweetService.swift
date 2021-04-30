//
//  TweetService.swift
//  twitterclone
//
//  Created by Rose Neezar on 14/04/2021.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String,type: UploadTweetConfiguration ,completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let values = [
            "uid":uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweets": 0,
            "caption": caption ] as [String : Any]
       
        switch type {
        case .tweet:
            
            REF_TWEETS.childByAutoId().updateChildValues(values) { (err, ref) in
            guard let tweetID = ref.key else {return}
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID : 1], withCompletionBlock: completion)
            }
            
        case .reply(let tweet):
            
            REF_TWEET_REPLIES.child(tweet.tweetID).childByAutoId().updateChildValues(values,withCompletionBlock: completion)
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
            self.fetchTweet(withTweetID: tweetID) { (tweet) in
                tweets.append(tweet)
                completion(tweets)
            }
          
        } withCancel: { (err) in
            print("DEBUG: Error \(err)")
        }
    }
    
    func fetchTweet(withTweetID tweetID: String, completion: @escaping(Tweet) -> Void) {
        REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { (snap) in
            guard let dictionary = snap.value as? [String: AnyObject] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user,tweetID: tweetID, dictionary: dictionary)
                completion(tweet)
            }
        }
    }
    
    func fetchReplies(forTweet tweet: Tweet, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEET_REPLIES.child(tweet.tweetID).observe(.childAdded) { (result) in
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
    
    func likeTweet(tweet: Tweet, completion: @escaping(DatabaseCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
        REF_TWEETS.child(tweet.tweetID).child("likes").setValue(likes)
        
        if tweet.didLike {
            //unlike
            REF_USER_LIKES.child(uid).child(tweet.tweetID).removeValue { (err, ref) in
                REF_TWEET_LIKES.child(tweet.tweetID).removeValue(completionBlock: completion)
            }
        } else {
            REF_USER_LIKES.child(uid).updateChildValues([tweet.tweetID: 1]) { (err, ref) in
                REF_TWEET_LIKES.child(tweet.tweetID).updateChildValues([uid: 1], withCompletionBlock: completion)
            }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        REF_USER_LIKES.child(uid).child(tweet.tweetID).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
    }
}
