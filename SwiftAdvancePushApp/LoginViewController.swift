//
//  LoginViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class LoginViewController: UIViewController,UITextFieldDelegate {
    // メールアドレス入力欄
    @IBOutlet weak var address: UITextField!
    // パスワード入力欄
    @IBOutlet weak var password: UITextField!
    // ステータス表示用ラベル
    @IBOutlet weak var statusLabel: UILabel!
    // AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextFieldにdelegateを設定
        address.delegate = self
        password.delegate = self
        // Passwordをセキュリティ入力に設定
        password.isSecureTextEntry = true
    }

    // 「ログイン」ボタン押下時の処理
    @IBAction func login(_ sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        // 入力確認
        if address.text!.isEmpty || password.text!.isEmpty {
            statusLabel.text = "未入力の項目があります"
            // TextFieldを空に
            cleanTextField()
            
            return
        }
        // 【mBaaS：会員管理②】メールアドレスとパスワードでログイン
        NCMBUser.logInInBackground(mailAddress: address.text!, password: password.text!, callback: { result in
            
            switch result {
                case .success:
                    if let user = NCMBUser.currentUser {
                        print("ログインしています。ユーザー: \(user.objectId!)")
                    } else {
                        print("ログインしていません")
                    }
                    // AppDelegateにユーザー情報を保持
                    self.appDelegate.current_user = NCMBUser.currentUser
                    // statusLabelを空にする
                    self.statusLabel.text = ""
                    // 画面遷移
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "login", sender: self)
                    }
                
                case let .failure(error):
                    print("ログインに失敗しました:\(error)")
                    self.statusLabel.text = "ログインに失敗しました:\(error)"
                }
        })
    }
    
    
    // 「会員登録」ボタン押下時の処理
    @IBAction func toSignUp(_ sender: UIButton) {
        // TextFieldを空にする
        cleanTextField()
        // statusLabelを空にする
        statusLabel.text = ""
        // キーボードを閉じる
        closeKeyboad()
    }
    
    // 背景タップ時にキーボードを隠す
    func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // TextFieldを空にする
    func cleanTextField(){
        address.text = ""
        password.text = ""
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        address.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
}
