import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTableView: UITableView!

    // Commentファイルのすべてのコメントを取得
    var comment = Comment.allComments()
    var post: Post!
    
    // Floating Buttonの宣言
    private var floatingButton: ActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // xibファイル(LeaveCommentTableViewCell)を上記commentViewControllerのTable Viewに配置
        let nib = UINib(nibName: "LeaveCommentTableViewCell", bundle: nil)
        commentTableView.registerNib(nib, forCellReuseIdentifier: "leaveCommentTableViewCell")

        // xibファイル(CommentTableViewCell)を上記commentViewControllerのTable Viewに配置
        let nib2 = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTableView.registerNib(nib2, forCellReuseIdentifier: "commentTableViewCell")

        // Table Viewの高さを指定
        commentTableView.estimatedRowHeight = 560

        // Table Viewが高さの指定値を越える場合に自動で調整
        commentTableView.rowHeight = UITableViewAutomaticDimension

        /* ナビゲーションバー...
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // ナビゲーションバーの色、hex:はSpringのライブラリで実行
        navigationController?.navigationBar.barTintColor = UIColor(hex: "330033") */
        
        // ナビゲーションバータイトルのフォントと色の指定
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Zapfino", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()]

        // ナビゲーションバーのタイトル
        title = "Grace"

        // ナビゲーションバーを表示
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBarHidden = false

        // ナビゲーションバーアイテムの表示を変更
        // navigationItem.leftBarButtonItem = UIBarButtonItem(title: <#T##String?#>, style: <#T##UIBarButtonItemStyle#>, target: <#T##AnyObject?#>, action: <#T##Selector#>)
        navigationItem.leftBarButtonItem?.title = "Back"

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
            print("Floating Button2 Tapped")
            
            // Floating Buttonがタップされた際に画面遷移(Segue)
            self.performSegueWithIdentifier("", sender: self)
        }
        
        // Floating Buttonのバックグラウンド色を指定
        floatingButton.backgroundColor = UIColor.clearColor()
    }

}

extension CommentViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(commentTableView: UITableView) -> Int {
        return 1
    }

    // 最初のRowにはPost Textを表示しその後にコメントを表示するため+1を入力
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (comment.count+1)
    }

    // 最初のRowにはPost Textを表示しその後に残りすべてのコメントを順番に表示
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = commentTableView.dequeueReusableCellWithIdentifier("leaveCommentTableViewCell", forIndexPath: indexPath) as! LeaveCommentTableViewCell
            cell.post = post
            return cell
        } else {
            let cell = commentTableView.dequeueReusableCellWithIdentifier("commentTableViewCell", forIndexPath: indexPath) as! CommentTableViewCell
            cell.comment = comment[indexPath.row-1]
            return cell
        }
    }

}
