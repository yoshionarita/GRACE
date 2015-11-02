import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!

    // Postの宣言
    var post = Post.allPosts

    // Floating Buttonの宣言
    private var floatingButton: ActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // xibファイル(HomeTableViewCell)を上記homeViewControllerのTable Viewに配置
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.registerNib(nib, forCellReuseIdentifier: "homeTableViewCell")

        // Table Viewの高さを指定
        homeTableView.estimatedRowHeight = 560

        // Table Viewが高さの指定値を越える場合に自動で調整
        homeTableView.rowHeight = UITableViewAutomaticDimension

        // ナビゲーションバー...
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        // ナビゲーションバーの色、hex:はSpringのライブラリで実行
        navigationController?.navigationBar.barTintColor = UIColor(hex: "330033")

        // ナビゲーションバータイトルのフォントと色の指定
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Zapfino", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()]

        // ナビゲーションバーのタイトル
        title = "Grace"

        // スクロール時のナビゲーションバーのSwipeでの非表示
        navigationController?.hidesBarsOnSwipe = true

        // Floating Buttonの配置
        createNewButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // ツールバーの非表示
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // Floating Buttonの設定
    private func createNewButton() {
        floatingButton = ActionButton(attachedToView: self.view, items: [])
        floatingButton.action = { button in
            print("Floating Button1 Tapped")

            // Floating Buttonがタップされた際に画面遷移(Segue)
            self.performSegueWithIdentifier("Post Composer", sender: self)
        }

        // Floating Buttonのバックグラウンド色を指定
        floatingButton.backgroundColor = UIColor.clearColor()
    }

    // データを画面遷移の際に移動させる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Comment Composer" {
            let commentViewController = segue.destinationViewController as! CommentViewController
            commentViewController.post = sender as! Post
        }
    }

}

// UITableViewDataSourceの宣言
extension HomeViewController: UITableViewDataSource {

    // Table Viewに入れるSection(見出し)数
    func numberOfSectionsInTableView(homeTableView: UITableView) -> Int {
        return 1
    }

    // Table Viewに入れるRow数
    func tableView(homeTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }

    /* Table Viewの中のCellを特定する、別途作成したxibファイルのIdentifierを入れる、
    asの後は本xibにひも付いたSwiftファイルを指定する */
    func tableView(homeTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCellWithIdentifier("homeTableViewCell", forIndexPath: indexPath) as! HomeTableViewCell

        // cellに代入したHomeTableViewCellを表示？
        cell.post = post[indexPath.row]
        cell.delegate = self

        return cell
    }

}

extension HomeViewController: HomeTableViewCellDelegate {
    func commentButtonTapped(post: Post) {
        self.performSegueWithIdentifier("Comment Composer", sender: post)
    }

    /* func postImageTapped(post: Post) {
        self.performSegueWithIdentifier("Comment Composer", sender: post)
    } */

}
