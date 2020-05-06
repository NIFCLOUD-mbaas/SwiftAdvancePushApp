//
//  SignUpViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
    @IBAction func signUp(_ sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        if address.text!.isEmpty {
            statusLabel.text = "メールアドレスを入力してください"
            return
        }
        
        // 【mBaaS：会員管理①】会員登録用メールを要求する
        NCMBUser.requestAuthenticationMailInBackground(mailAddress: address.text!, callback: { result in
            switch result {
                case .success:
                    // 会員登録用メールの要求失敗時の処理
                    print("登録用メールを送信しました")
                    self.statusLabel.text = "登録用メールを送信しました"
                    // TextFieldを空にする
                    self.address.text = ""
                case let .failure(error):
                    // 会員登録用メールの要求失敗時の処理
                    print("エラーが発生しました：\(error)")
                    self.statusLabel.text = "エラーが発生しました：\(error)"
            }
        })
    }
    
    // 背景タップ時にキーボードを隠す
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        address.resignFirstResponder()
    }
    
    // キーボードの「Return」押下時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }    
}
