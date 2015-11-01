import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var userLikesLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!

    @IBOutlet weak var postTextLabelConstraint: NSLayoutConstraint!

    /* DummyData - Post.swiftから画面を生成、
    Table Viewを最初に表示するためにダミーで作成する、
    didSetは当初表示された際に、Post (API) から情報を取得してUIを更新する */
    var post: Post! {
        didSet {
            updateUI()
        }
    }

    // 当初ユーザーはLikeをしていない
    private var currentUserDidLike: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func likeButtonTapped(sender: AnyObject) {

        // LikeボタンをタップするとLike数が+1増加、再タップで-1減少
        post.userDidLike = !post.userDidLike
        if post.userDidLike {
            post.numberOfLikes++
        } else {
            post.numberOfLikes--
        }

        // Like数を表示する
        userLikesLabel.text = "\(post.numberOfLikes) Likes"
        currentUserDidLike = post.userDidLike

        // Likeボタンタップ時に画像を変更
        changeLikeButtonImage()
    }

    @IBAction func commentButtonTapped(sender: AnyObject) {
    }

    /* privateは本ファイル内でのみ使うfuncという意味、
    　　ファイルが増えた際にfunc同士が混乱しないように配慮している、
    updateUIは最新の画面を更新して表示する */
    private func updateUI() {

        // プロフィール画像を円形にする
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true

        // Post画像の角の丸みを指定
        postImage.layer.cornerRadius = 5.0
        postImage.clipsToBounds = true

        // プロフィール画像・名前・投稿日などにダミーを入れる
        userProfileImage.image! = post.user.profileImage
        usernameLabel.text! = post.user.fullName
        createdAtLabel.text! = post.createdAt
        postImage.image! = post.postImage
        postTextLabel.text! = post.postText

        // 最新のLike数に更新
        userLikesLabel.text = "\(post.numberOfLikes) Likes"

        // Likeボタンタップ時に画像を変更
        changeLikeButtonImage()

        // Like数が1以下の場合はLike数を非表示
        if post.numberOfLikes <= 1 {
            userLikesLabel.hidden = true

            // 表示しない場合Like数の分を上に詰める
            self.postTextLabelConstraint.constant = -20
        } else {
            userLikesLabel.hidden = false
        }
    }

    // Likeボタンタップ時に画像を変更
    private func changeLikeButtonImage() {
        if currentUserDidLike {
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonTapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        } else {
            let likeButtonImageTapped: UIImage? = UIImage(named: "likeButtonUntapped")
            likeButton.setImage(likeButtonImageTapped!, forState: .Normal)
        }
    }

}
