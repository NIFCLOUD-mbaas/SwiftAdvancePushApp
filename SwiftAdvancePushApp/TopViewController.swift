//
//  TopViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

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
        if NCMBUser.currentUser!["nickname"] == nil {
            // ユーザー情報登録Viewを表示
            self.userRegisterView()
        } else {
            let nickname = NCMBUser.currentUser!["nickname"]! as String
            nicknameLabel.text = "\(nickname)さん、こんにちは！"
            // 画面更新
            checkShop()
        }
    }

    //　mBaaSに登録されているShop情報を取得してテーブルに表示する
    func checkShop() {
        // 【mBaaS：データストア】「Shop」クラスのデータを取得
        // 「Shop」クラスのクエリを作成
        let query =  NCMBQuery.getQuery(className: "Shop")
        // データストアを検索
        query.findInBackground(callback: { result in
            switch result {
            case let .success(array):
                // 検索成功時の処理
                print("検索に成功しました")
                // AppDelegateに「Shop」クラスの情報を保持
                self.appDelegate.shopList = array
                // テーブルの更新
                DispatchQueue.main.async {
                    self.shopTableView.reloadData()
                }
            case let .failure(error):
                // 検索失敗時の処理
                print("検索に失敗しました:\(error)")
            }
        })
       
    }

    // shopTableViewのセル表示数を設定
    func tableView(_ table: UITableView, numberOfRowsInSection section:Int) -> Int {
        return NUMBER_OF_SHOPS
    }

    // shopTableViewのセルの内容を設定
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cellデータを取得
        let cell: CustomCell = shopTableView.dequeueReusableCell(withIdentifier: "shopTableCell", for: indexPath) as! CustomCell
        // cell

        // 「表示件数」＜「取得件数」の場合objectを作成
        var object: NCMBObject?
        if indexPath.row < self.appDelegate.shopList.count {
            object = self.appDelegate.shopList[indexPath.row]
        }
        // cellにデータを設定
        if let unwrapObject  = object {
            cell.setCell_top(object: unwrapObject)
        }
        return cell
    }

    // cellを選択したときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移
        performSegue(withIdentifier: "toShopPage", sender: indexPath.row)
    }

    // segueの設定（全てのsegueで呼ばれるメソッド）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // ShopViewへ画面遷移（toShopPage）する場合の処理
        if segue.identifier == "toShopPage" {
            //　TableViewのindex.rowの値をShopViewへ渡す
            let shopViewController: ShopViewController = segue.destination as! ShopViewController
            shopViewController.shopIndex = sender as? Int
        }
    }

    // 「ログアウト」ボタン押下時の処理
    @IBAction func logOut(_ sender: UIButton) {
        // ログアウト
        NCMBUser.logOut()
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }

    /** ▼初回ユーザー情報登録画面の処理▼ **/
     // ユーザー情報登録画面の作成
    private func userRegisterView() {
        // Viewを生成
        registerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        // 背景を黒に設定
        registerView.backgroundColor = UIColor.black
        // titleLabelを生成
        let titleLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.3, y: (self.view.bounds.size.height)*0.18, width: (self.view.bounds.size.width)*0.7, height: 45))
        titleLabel.text = "♡ユーザー情報登録♡"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        // nicknameLabelを生成
        let nicknameLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.29, width: 75, height: 20))
        nicknameLabel.text = "ニックネーム"
        nicknameLabel.textAlignment = NSTextAlignment.left
        nicknameLabel.textColor = UIColor.white
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        // nicknameを生成
        nickname = UITextField(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.33, width: (self.view.bounds.size.width)*0.65, height: 30))
        nickname.borderStyle = UITextField.BorderStyle.roundedRect
        nickname.font = UIFont.systemFont(ofSize: 14)
        nickname.backgroundColor = UIColor.white
        nickname.delegate = self
        // genderLabelを生成
        let genderLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.40, width: 75, height: 20))
        genderLabel.text = "性別"
        genderLabel.textAlignment = NSTextAlignment.left
        genderLabel.textColor = UIColor.white
        genderLabel.font = UIFont.boldSystemFont(ofSize: 10)
        genderSegCon = UISegmentedControl(items: GENDER_CONFIG as [AnyObject])
        genderSegCon.frame = CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.44, width: (self.view.bounds.size.width)*0.65, height: 30)
        genderSegCon.addTarget(self, action:#selector(segConChanged), for: UIControl.Event.valueChanged)
        genderSegCon.tintColor = UIColor(red: 0.243, green: 0.627, blue: 0.929, alpha: 1) // R:62 G:160 B:237
        // prefectureLabelを生成
        let prefectureLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.52, width: 75, height: 20))
        prefectureLabel.text = "都道府県"
        prefectureLabel.textAlignment = NSTextAlignment.left
        prefectureLabel.textColor = UIColor.white
        prefectureLabel.font = UIFont.boldSystemFont(ofSize: 10)
        // prefectureを生成
        prefecture = UITextField(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.56, width: (self.view.bounds.size.width)*0.65, height: 30))
        prefecture.borderStyle = UITextField.BorderStyle.roundedRect
        prefecture.font = UIFont.systemFont(ofSize: 14)
        prefecture.backgroundColor = UIColor.white
        prefecture.delegate = self
        // viewLabelを生成
        viewLabel = UILabel(frame: CGRect(x: (self.view.bounds.size.width/2)*0.35, y: (self.view.bounds.size.height)*0.65, width: (self.view.bounds.size.width)*0.65, height: 30))
        viewLabel.font = UIFont.systemFont(ofSize: 15)
        viewLabel.textColor = UIColor.white
        viewLabel.textAlignment = NSTextAlignment.center
        // registerButtonを生成
        let regsterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 48))
        regsterButton.center = CGPoint(x: self.view.bounds.size.width/2, y: (self.view.bounds.size.height)*0.8)
        regsterButton.setImage(UIImage(named: "setup"), for: UIControl.State.normal)
        regsterButton.addTarget(self, action:#selector(userInfoRegister), for: .touchUpInside)

        // gestureを生成
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(tapScreen))

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
    @objc internal func segConChanged(sender: UISegmentedControl) {
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
    @objc internal func userInfoRegister(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        // 入力確認
        if nickname.text!.isEmpty || prefecture.text!.isEmpty || genderSegCon.selectedSegmentIndex == -1 {
            viewLabel.text = "未入力の項目があります"
            return
        }
        // 【mBaaS：会員管理③】ユーザー情報更新
        // ログイン中のユーザーを取得
        let user:NCMBUser = NCMBUser.currentUser!
        // ユーザー情報を設定
        user["nickname"] = self.nickname.text
        user["gender"] = self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex]
        user["prefecture"] = self.prefecture.text
        user["favorite"] = [] as Array<String>
        // user情報の更新
        user.saveInBackground(callback: { result in
            switch result {
                case .success:
                    // 更新成功時の処理
                    print("ユーザー情報更新に成功しました")
                    // AppDelegateに保持していたユーザー情報の更新
                    self.appDelegate.current_user = user as NCMBUser
                    // 【mBaaS：プッシュ通知③】installationにユーザー情報を紐づける
                    // 使用中端末のinstallation取得
                    let installation = NCMBInstallation.currentInstallation
                    // ユーザー情報を設定
                    DispatchQueue.main.async {
                        installation["nickname"] = self.nickname.text
                        installation["gender"] = self.GENDER_CONFIG[self.genderSegCon.selectedSegmentIndex]
                        installation["prefecture"] = self.prefecture.text
                    }
                    installation["favorite"] = [] as Array<String>
                    // installation情報の更新
                    installation.saveInBackground(callback: { result in
                        switch result {
                        case .success:
                            // installation更新成功時の処理
                            print("installation更新(ユーザー登録)に成功しました")

                            DispatchQueue.main.async {
                                // 画面を閉じる
                                self.registerView.isHidden = true
                                // ニックネーム表示用ラベルの更新
                                let nickname = NCMBUser.currentUser!["nickname"]! as String
                                self.nicknameLabel.text = "\(nickname)さん、こんにちは！"
                            }
                            // 画面更新
                            self.checkShop()
                        case let .failure(error):
                            // installation更新失敗時の処理
                            print("installation更新(ユーザー登録)に失敗しました:\(error)")
                        }
                    })
                case let .failure(error):
                    // 更新失敗時の処理
                    print("ユーザー情報更新に失敗しました:\(error)")
                    DispatchQueue.main.async {
                        self.viewLabel.text = "登録に失敗しました（更新）:\(error)"
                    }
                }
        })
    }
    /** ▲初回ユーザー情報登録画面の処理▲ **/

    // 背景タップ時にキーボードを隠す
    @objc func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    // キーボードを閉じる
    func closeKeyboad(){
        nickname.resignFirstResponder()
        prefecture.resignFirstResponder()
    }

    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}
