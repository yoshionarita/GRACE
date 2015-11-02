import UIKit

class LeaveCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userLikesLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!

    @IBOutlet weak var postTextLabelConstraint: NSLayoutConstraint!

    private var currentUserDidLike: Bool = false

    var post: Post! {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func likeButtonTapped(sender: AnyObject) {

        // LikeボタンをタップするとLike数が+1増加・画像変更、再タップで-1減少・元画像へ戻る
        post.userDidLike = !post.userDidLike
        if post.userDidLike {
            post.numberOfLikes++
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonTapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        } else {
            post.numberOfLikes--
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonUntapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        }

        // Like数を表示する
        userLikesLabel.text = "\(post.numberOfLikes) Likes"
        currentUserDidLike = post.userDidLike
    }

    // 最新の画面を更新して表示
    private func updateUI() {

        // プロフィール画像を円形にする
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
        
        // Post画像の角の丸みを指定
        postImage.layer.cornerRadius = 7.0
        postImage.clipsToBounds = true

        // プロフィール画像・名前・投稿日などにダミーを入れる
        userProfileImage.image! = post.user.profileImage
        usernameLabel.text! = post.user.fullName
        createdAtLabel.text! = post.createdAt
        postImage.image! = post.postImage
        postTextLabel.text! = post.postText

        // Likeボタンをタップしている場合(post.userDidLike)画像が変更
        if post.userDidLike {
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonTapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        } else {
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonUntapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        }

        // 最新のLike数に更新
        userLikesLabel.text = "\(post.numberOfLikes) Likes"

        // Like数が1以下の場合はLike数を非表示
        if post.numberOfLikes < 2 {
            userLikesLabel.hidden = true

            // 表示しない場合Like数の分を上に詰める
            // postTextLabelConstraint.constant = -20
        } else {
            userLikesLabel.hidden = false
        }
    }

}
