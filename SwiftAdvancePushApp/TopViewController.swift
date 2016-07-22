//
//  TopViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class TopViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    // ニックネーム表示用ラベル
    @IBOutlet weak var nicknameLabel: UILabel!
    // Shop一覧表示用テーブル
    @IBOutlet weak var shopTableView: UITableView!
    // テーブル表示件数
    var NUMBER_OF_SHOPS = 4
    // AppDelegate
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    /** ▼初回ユーザー情報登録画面用▼ **/
    var registerView: UIView!
    var viewLabel: UILabel!
    var nickname: UITextField!
    var prefecture: UITextField!
    var genderSegCon: UISegmentedControl!
    let GENDER_CONFIG = ["男性","女性"]
    /** ▲初回ユーザー情報登録画面用▲**/
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableViewの設定
        shopTableView.delegate = self
        shopTableView.dataSource = self
        // ユーザー情報が未登録の場合
        if appDelegate.current_user.objectForKey("nickname") == nil {
            // ユーザー情報登録Viewを表示
            self.userRegisterView()
        } else {
            nicknameLabel.text = "\(appDelegate.current_user.objectForKey("nickname"))さん、こんにちは！"
            // 画面更新
            checkShop()
        }
    }
    
    //　mBaaSに登録されているShop情報を取得してテーブルに表示する
    func checkShop() {
        // 【mBaaS：データストア】「Shop」クラスのデータを取得
        // 「Shop」クラスのクエリを作成
        let query = NCMBQuery(className: "Shop")
        // データストアを検索
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                // 検索失敗時の処理
                print("検索に失敗しました:\(error.code)")
            } else {
                // 検索成功時の処理
                print("検索に成功しました")
                // AppDelegateに「Shop」クラスの情報を保持
                self.appDelegate.shopList = objects as! Array
                // テーブルの更新
                self.shopTableView.reloadData()
            }
        })
    }
    
    // shopTableViewのセル表示数を設定
    func tableView(table: UITableView, numberOfRowsInSection section:Int) -> Int {
        return NUMBER_OF_SHOPS
    }
    
    // shopTableViewのセルの内容を設定
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // cellデータを取得
        let cell: CustomCell = shopTableView.dequeueReusableCellWithIdentifier("shopTableCell", forIndexPath: indexPath) as! CustomCell
        // cell
        
        // 「表示件数」＜「取得件数」の場合objectを作成
        var object: NCMBObject?
        if indexPath.row < self.appDelegate.shopList.count {
            object = self.appDelegate.shopList[indexPath.row]
        }
        // cellにデータを設定
        if let unwrapObject  = object {
            cell.setCell_top(unwrapObject)
        }
        return cell
    }
    
    // cellを選択したときの処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 画面遷移
        performSegueWithIdentifier("toShopPage", sender: indexPath.row)
    }
    
    // segueの設定（全てのsegueで呼ばれるメソッド）
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // ShopViewへ画面遷移（toShopPage）する場合の処理
        if segue.identifier == "toShopPage" {
            //　TableViewのindex.rowの値をShopViewへ渡す
            let shopViewController: ShopViewController = segue.destinationViewController as! ShopViewController
            shopViewController.shopIndex = sender as! Int
        }
    }
    
    // 「ログアウト」ボタン押下時の処理
    @IBAction func logOut(sender: UIBarButtonItem) {
        // ログアウト
        NCMBUser.logOut()
        // 画面を閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /** ▼初回ユーザー情報登録画面の処理▼ **/
     // ユーザー情報登録画面の作成
    private func userRegisterView() {
        // Viewを生成
        registerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        // 背景を黒に設定
        registerView.backgroundColor = UIColor.blackColor()
        // titleLabelを生成
        let titleLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.3, y: (self.view.bounds.size.height)*0.18, width: (self.view.bounds.size.width)*0.7, height: 45))
        titleLabel.text = "♡ユーザー情報登録♡"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(25)
        // nicknameLabelを生成
        let nicknameLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.29, width: 75, height: 20))
        nicknameLabel.text = "ニックネーム"
        nicknameLabel.textAlignment = NSTextAlignment.Left
        nicknameLabel.textColor = UIColor.whiteColor()
        nicknameLabel.font = UIFont.boldSystemFontOfSize(10)
        // nicknameを生成
        nickname = UITextField(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.33, width: (self.view.bounds.size.width)*0.65, height: 30))
        nickname.borderStyle = UITextBorderStyle.RoundedRect
        nickname.font = UIFont.systemFontOfSize(14)
        nickname.backgroundColor = UIColor.whiteColor()
        nickname.delegate = self
        // genderLabelを生成
        let genderLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.40, width: 75, height: 20))
        genderLabel.text = "性別"
        genderLabel.textAlignment = NSTextAlignment.Left
        genderLabel.textColor = UIColor.whiteColor()
        genderLabel.font = UIFont.boldSystemFontOfSize(10)
        genderSegCon = UISegmentedControl(items: GENDER_CONFIG as [AnyObject])
        genderSegCon.frame = CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.44, width: (self.view.bounds.size.width)*0.65, height: 30)
        genderSegCon.addTarget(self, action: "segConChanged:", forControlEvents: UIControlEvents.ValueChanged)
        genderSegCon.tintColor = UIColor(red: 0.243, green: 0.627, blue: 0.929, alpha: 1) // R:62 G:160 B:237
        // prefectureLabelを生成
        let prefectureLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.52, width: 75, height: 20))
        prefectureLabel.text = "都道府県"
        prefectureLabel.textAlignment = NSTextAlignment.Left
        prefectureLabel.textColor = UIColor.whiteColor()
        prefectureLabel.font = UIFont.boldSystemFontOfSize(10)
        // prefectureを生成
        prefecture = UITextField(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.56, width: (self.view.bounds.size.width)*0.65, height: 30))
        prefecture.borderStyle = UITextBorderStyle.RoundedRect
        prefecture.font = UIFont.systemFontOfSize(14)
        prefecture.backgroundColor = UIColor.whiteColor()
        prefecture.delegate = self
        prefecture.keyboardType = UIKeyboardType.NumberPad
        // viewLabelを生成
        viewLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.65, width: (self.view.bounds.size.width)*0.65, height: 30))
        viewLabel.font = UIFont.systemFontOfSize(15)
        viewLabel.textColor = UIColor.whiteColor()
        viewLabel.textAlignment = NSTextAlignment.Center
        // registerButtonを生成
        let regsterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 48))
        regsterButton.center = CGPoint(x: self.view.bounds.size.width/2, y: (self.view.bounds.size.height)*0.8)
        regsterButton.setImage(UIImage(named: "setup"), forState: UIControlState.Normal)
        regsterButton.addTarget(self, action: "userInfoRegister:", forControlEvents: .TouchUpInside)
        // gestureを生成
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapScreen:")
        // Viewに設定
        self.view.addSubview(registerView)
        self.registerView.addSubview(titleLabel)
        self.registerView.addSubview(nicknameLabel)
        self.registerView.addSubview(nickname)
        self.registerView.addSubview(genderSegCon)
        self.registerView.addSubview(genderLabel)
        self.registerView.addSubview(prefectureLabel)
        self.registerView.addSubview(prefecture)
        self.registerView.addSubview(viewLabel)
        self.registerView.addSubview(regsterButton)
        self.registerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // genderSegConの値が変わったときに呼び出されるメソッド
    internal func segConChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("男性")
        case 1:
            print("女性")
        default:
            print("NG")
        }
    }
    
    // 「登録」ボタン押下時の処理
    internal func userInfoRegister(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        // 入力確認
        if nickname.text!.isEmpty || prefecture.text!.isEmpty || genderSegCon.selectedSegmentIndex == -1 {
            viewLabel.text = "未入力の項目があります"
            return
        }
        // 【mBaaS：会員管理③】ユーザー情報更新
        // ログイン中のユーザーを取得
        let user = NCMBUser.currentUser()
        // ユーザー情報を設定
        user.setObject(self.nickname.text, forKey: "nickname")
        user.setObject(self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex], forKey: "gender")
        user.setObject(self.prefecture.text, forKey: "prefecture")
        user.setObject([] as Array<String>, forKey: "favorite")
        // user情報の更新
        user.saveInBackgroundWithBlock({(error: NSError!) -> Void in
            if error != nil {
                // 更新失敗時の処理
                print("ユーザー情報更新に失敗しました:\(error.code)")
                self.viewLabel.text = "登録に失敗しました（更新）:\(error.code)"
            } else {
                // 更新成功時の処理
                print("ユーザー情報更新に成功しました")
                // AppDelegateに保持していたユーザー情報の更新
                self.appDelegate.current_user = user as NCMBUser
                // 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
                let installation = NCMBInstallation.currentInstallation()
                // ユーザー情報を設定
                installation.setObject(self.nickname.text, forKey: "nickname")
                installation.setObject(self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex], forKey: "gender")
                installation.setObject(self.prefecture.text, forKey: "prefecture")
                installation.setObject([] as Array<String>, forKey: "favorite")
                // installation情報の更新
                installation.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
                    if error != nil {
                        // installation更新失敗時の処理
                        print("installation更新(ユーザー登録)に失敗しました:\(error.code)")
                    } else {
                        // installation更新成功時の処理
                        print("installation更新(ユーザー登録)に成功しました")
                    }
                })
                // 画面を閉じる
                self.registerView.hidden = true
                // ニックネーム表示用ラベルの更新
                self.nicknameLabel.text = "\(self.appDelegate.current_user.objectForKey("nickname"))さん、こんにちは！"
                // 画面更新
                self.checkShop()
            }
        })
    }
    /** ▲初回ユーザー情報登録画面の処理▲ **/
    
    // 背景タップ時にキーボードを隠す
    func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        nickname.resignFirstResponder()
        prefecture.resignFirstResponder()
        nicknameLabel.resignFirstResponder()
    }
    
    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}