//
//  Post.swift
//  Twitter
//
//  Created by Ryosuke Fukuda on 8/15/15.
//  Copyright (c) 2015 Ryochan. All rights reserved.
//

import UIKit

class Post {
    
    // プロパティ
    var id: String
    var user: User
    var createdAt: String

    // 写真がない可能性もある
    var postImage: UIImage!

    var postText: String
    var numberOfLikes: Int = 0
    var userDidLike = false
    
    // このIDはParseからデータを習得するときに必要
    let interestId: String
    
    // ポストIDはポストのデータを習得するときに必要
    init(postId: String, author: User, createdAt: String, postImage: UIImage!, postText: String, numberOfLikes: Int, interestId: String, userDidLike: Bool)
    {
        self.id = postId
        self.user = author
        self.createdAt = createdAt
        self.postImage = postImage      // なしでもOK
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.interestId = interestId
        self.userDidLike = userDidLike
    }

    // ダミーデータ
    static let allPosts = [
        Post(postId: "s4", author: User.allUsers()[1], createdAt: "Today", postImage: UIImage(named: "defaultPostImage")!, postText: "Today, we’re announcing Boomerang from Instagram, a new video app that lets you turn everyday moments into something fun and unexpected.", numberOfLikes: 1, interestId: "i4", userDidLike: false),
        Post(postId: "s3", author: User.allUsers()[0], createdAt: "Today", postImage: UIImage(named: "userHeaderImage1")!, postText: "Capture a friend jumping off a diving board, defying physics as she flies back and forth through the air.", numberOfLikes: 2, interestId: "i3", userDidLike: false),
        Post(postId: "s2", author: User.allUsers()[1], createdAt: "Yesterday", postImage: UIImage(named: "userHeaderImage2")!, postText: "Transform an ordinary selfie with your friends into a funny video.", numberOfLikes: 3, interestId: "i2", userDidLike: false),
        Post(postId: "s1", author: User.allUsers()[0], createdAt: "2 Days ago", postImage: UIImage(named: "userHeaderImage1")!, postText: "Get that exact moment your friend blows out his birthday candles, then watch them come back to life again and again.", numberOfLikes: 4, interestId: "t1", userDidLike: false),
    ]

}
