//
//  User.swift
//  Twitter
//
//  Created by Ryosuke Fukuda on 8/15/15.
//  Copyright (c) 2015 Ryochan. All rights reserved.
//

import UIKit

class User {

    var id: String
    var fullName: String
    var email: String
    var profileImage: UIImage!
    var profileHeaderImage: UIImage!
    var interestId = [String]()

    init(id: String, fullName: String, email: String, profileImage: UIImage, headerImage: UIImage!) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
        self.profileHeaderImage = headerImage
    }

    // MARK: - Private
    class func allUsers() -> [User]
    {
        return [
            User(id: "f1", fullName: "Amanda Lin", email: "amanda@lin.com", profileImage: UIImage(named: "userProfileImage1")!, headerImage: UIImage(named: "userHeaderImage1")!),
            User(id: "f2", fullName: "Kim Chua", email: "kim@chua.com", profileImage: UIImage(named: "userProfileImage2")!, headerImage: UIImage(named: "userHeaderImage2"))
        ]
    }

}
