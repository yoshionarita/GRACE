//
//  Comment.swift
//  Twitter
//
//  Created by Ryosuke Fukuda on 8/15/15.
//  Copyright (c) 2015 Ryochan. All rights reserved.
//

import UIKit

class Comment {
    
    var id: String = ""
    var createdAt: String = "today"
    let postId: String
    let user: User
    var commentText: String
    var numberOfLikes: Int
    
    init(id: String, createdAt: String, postId: String, author: User, commentText: String, numberOfLikes: Int)
    {
        self.id = id
        self.createdAt = createdAt
        self.postId = postId
        self.user = author
        self.commentText = commentText
        self.numberOfLikes = numberOfLikes
    }
    
    // ダミーデータ
    static func allComments() -> [Comment]
    {
        return [
            Comment(id: "c5", createdAt: "May 25", postId: "f4", author: User.allUsers()[0], commentText: "Press a button and the app does the rest.", numberOfLikes: 1),
            Comment(id: "c4", createdAt: "May 24", postId: "f3", author: User.allUsers()[0], commentText: "Boomerang takes a burst of photos and stitches them together into a high-quality mini video that plays forward and backward.", numberOfLikes: 2),
            Comment(id: "c3", createdAt: "May 22", postId: "f2", author: User.allUsers()[0], commentText: "Shoot in portrait or landscape. Share it on Instagram. Boomerang automatically saves it to your camera roll.", numberOfLikes: 3),
            Comment(id: "c2", createdAt: "May 21", postId: "f1", author: User.allUsers()[0], commentText: "Great!", numberOfLikes: 5),
            Comment(id: "c1", createdAt: "May 21", postId: "f1", author: User.allUsers()[0], commentText: " We’re inspired by the visual stories you tell on Instagram. With looping videos and Hyperlapse, you experiment with motion in new and exciting ways.", numberOfLikes: 10)
        ]
    }
    
}
