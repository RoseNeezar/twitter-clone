//
//  UploadTweetViewModel.swift
//  twitterclone
//
//  Created by Rose Neezar on 25/04/2021.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    
    let actionButtonTitle: String
    let placeHolderText: String
    let shouldShowReplyTweet: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeHolderText = "What's happening?"
            shouldShowReplyTweet = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeHolderText = "Tweet your reply"
            shouldShowReplyTweet = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
