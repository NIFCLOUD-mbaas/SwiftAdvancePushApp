//
//  SignUpViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/06.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {
    // メールアドレス入力欄
    @IBOutlet weak var address: UITextField!
    // ステータス表示用ラベル
    @IBOutlet weak var label: UILabel!
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        address.delegate = self
    }
    
    // 「登録メールを送信」ボタン押下時の処理
    @IBAction func signUp(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        if address.text!.isEmpty {
            label.text = "メールアドレスを入力してください"
            return
        }
        
        // 【mBaaS：会員管理】会員登録用メールを要求する
        var error: NSError? = nil
        NCMBUser.requestAuthenticationMail(address.text, error: &error)
        if error != nil {
            // 会員登録用メールの要求失敗時の処理
            print("エラーが発生しました：\(error!.code)")
            label.text = "エラーが発生しました：\(error!.code)"
        } else {
            // 会員登録用メールの要求失敗時の処理
            print("登録用メールを送信しました")
            label.text = "登録用メールを送信しました"
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
        label.resignFirstResponder()
    }
    
    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }    
}