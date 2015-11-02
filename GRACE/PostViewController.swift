import UIKit
import Photos

class PostViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTextLabel: UITextView!

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!

    // Image Picker SheetでPost Imageに保存した画像が表示される
    private var imagePickerSheet: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ナビゲーションバーを直接付けた場合navigationControllerは付けない
        navigationBar.tintColor = UIColor.whiteColor()
        
        // ナビゲーションバーの色、hex:はSpringのライブラリで実行
        navigationBar.barTintColor = UIColor(hex: "330033")
        
        // ナビゲーションバータイトルのフォントと色の指定
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Zapfino", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()]

        // プロフィール画像を円形にする
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
        
        // Post Textを空にして遷移後最初にレスポンスさせることでキーボードを表示する
        postTextLabel.text = ""
        postTextLabel.becomeFirstResponder()

        // Notification Center - キーボードが現れるor隠れる状態を設定
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backButtonTapped(sender: AnyObject) {

        // 上記アクション後にpostTextの動きを最初に実行しキーボードを先に仕舞う
        postTextLabel.resignFirstResponder()
        
        // Navigation Barを使用せずに画面遷移させた後、前画面に戻る
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func postButtonTapped(sender: AnyObject) {

        // 上記アクション後にpostTextの動きを最初に実行しキーボードを先に仕舞う
        postTextLabel.resignFirstResponder()

        // Navigation Barを使用していない際に前画面に戻す
        dismissViewControllerAnimated(true, completion: nil)
    }

    // Observerのデイニシャライザー・初期化
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // キーボードが隠れる際にPost Textが元に戻る
    func keyboardWillHide(notification: NSNotification) {
        self.postTextLabel.contentInset = UIEdgeInsetsZero
        self.postTextLabel.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    // キーボードが現れる際にユーザー端末の情報からキーボードのサイズを取得
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        // Post Text Labeのサイズを上記で取得したキーボードのサイズに合わせる
        self.postTextLabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height+10, right: 0)
        self.postTextLabel.scrollIndicatorInsets = self.postTextLabel.contentInset
    }

    // ツールバーの非表示
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func postImageTapped(sender: AnyObject) {

        // 画像アクセスへの許可確認
        let authorization = PHPhotoLibrary.authorizationStatus()

        // もし画像アクセスへの許可が無い場合、許可を依頼する
        if authorization == .NotDetermined {
            PHPhotoLibrary.requestAuthorization( { (status) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.postImageTapped(sender)
                })
            })
            return
        }

        // もし画像アクセスへの許可がある場合、ImagePickerSheetControllerを実行
        if authorization == .Authorized {
            let controller = ImagePickerSheetController()

            // 写真を撮影するかの確認
            controller.addAction(ImageAction(title: NSLocalizedString("Take a Photo", comment: "ActionTitle"),
                
                // 撮影しない場合(secondaryTitle)保存してある画像を選択
                secondaryTitle: NSLocalizedString("Use This Photo", comment: "ActionTitle"), handler: {(_) -> () in

                self.presentCamera()

                // 選択した画像を取得をPost Imageに表示
                }, secondaryHandler: {(action, numberOfPhoto) -> () in
                    controller.getSelectedImagesWithCompletion({(images) -> Void in
                    self.imagePickerSheet = images[0]
                    self.postImage.image = self.imagePickerSheet
                })
            }))

            // ImagePickerSheetControllerをキャンセルして前画面に戻る
            controller.addAction(ImageAction(title: NSLocalizedString("Cancel", comment: "ActionTitle"), style: .Cancel, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
        }

    }

    // UIImagePickerControllerを実行、カメラを起動して画像を取得
    func presentCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    // 上記の画像取得後にPost Imageに画像を表示し、ImagePickerSheetControllerを閉じる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.postImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
