//
//  SignUpViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {
    // メールアドレス入力欄
    @IBOutlet weak var address: UITextField!
    // ステータス表示用ラベル
    @IBOutlet weak var statusLabel: UILabel!
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextFieldにdelegateを設定
        address.delegate = self
    }
    
    // 「登録メールを送信」ボタン押下時の処理
    @IBAction func signUp(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        if address.text!.isEmpty {
            statusLabel.text = "メールアドレスを入力してください"
            return
        }
        
        // 【mBaaS：会員管理①】会員登録用メールを要求する
        NCMBUser.requestAuthenticationMailInBackground(address.text) { (error: NSError!) -> Void in
            if error != nil {
                // 会員登録用メールの要求失敗時の処理
                print("エラーが発生しました：\(error!.code)")
                self.statusLabel.text = "エラーが発生しました：\(error!.code)"
            } else {
                // 会員登録用メールの要求失敗時の処理
                print("登録用メールを送信しました")
                self.statusLabel.text = "登録用メールを送信しました"
                // TextFieldを空にする
                self.address.text = ""
            }
        }
        
        // TextFieldを空にする
        address.text = ""
    }
    
    // 背景タップ時にキーボードを隠す
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        address.resignFirstResponder()
    }
    
    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }    
}