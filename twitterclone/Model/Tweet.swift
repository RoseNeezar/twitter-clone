//
//  Tweet.swift
//  twitterclone
//
//  Created by Rose Neezar on 15/04/2021.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    var uid: String
    var likes: Int
    var timestamp: Date!
    let retweetCount: Int
    var user: User
    var didLike = false
    
    init(user: User,tweetID: String, dictionary: [String: AnyObject]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["username"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
