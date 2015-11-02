import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!

    var comment: Comment! {
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

    // layoutSubviewsはCell内のレイアウトの指定に使用
    override func layoutSubviews() {
        super.layoutSubviews()

        // プロフィール画像を円形にする
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
    }

    private func updateUI() {
        userProfileImage.image! = comment.user.profileImage
        usernameLabel.text! = comment.user.fullName
        createdAtLabel.text! = comment.createdAt
        commentTextLabel.text! = comment.commentText
    }

}
