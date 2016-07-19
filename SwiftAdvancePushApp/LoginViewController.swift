//
//  ViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
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
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextFieldにdelegateを設定
        address.delegate = self
        password.delegate = self
        // Passwordをセキュリティ入力に設定
        password.secureTextEntry = true
    }

    // 「ログイン」ボタン押下時の処理
    @IBAction func login(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        // 入力確認
        if address.text!.isEmpty || password.text!.isEmpty {
            statusLabel.text = "未入力の項目があります"
            // TextFieldを空に
            cleanTextField()
            
            return
        }
        // 【mBaaS：会員管理】メールアドレスとパスワードでログイン
        NCMBUser.logInWithMailAddressInBackground(address.text, password: password.text) { (user: NCMBUser!, error: NSError!) -> Void in
            if error != nil {
                // ログイン失敗時の処理
                print("ログインに失敗しました:\(error.code)")
                self.statusLabel.text = "ログインに失敗しました:\(error.code)"
            }else{
                // ログイン成功時の処理
                print("ログインに成功しました:\(user.objectId)")
                // AppDelegateにユーザー情報を保持
                self.appDelegate.current_user = user as NCMBUser
                // TextFieldを空にする
                self.cleanTextField()
                // statusLabelを空にする
                self.statusLabel.text = ""
                // 画面遷移
                self.performSegueWithIdentifier("login", sender: self)
            }
        }
    }
    
    // 「会員登録」ボタン押下時の処理
    @IBAction func toSignUp(sender: UIButton) {
        // TextFieldを空にする
        cleanTextField()
        // statusLabelを空にする
        statusLabel.text = ""
        // キーボードを閉じる
        closeKeyboad()
    }
    
    // 背景タップ時にキーボードを隠す
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
}