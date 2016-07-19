//
//  UserInfoViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class UserInfoViewController: UIViewController {
    // メールアドレス表示用ラベル
    @IBOutlet weak var mailAddress: UILabel!
    // ニックネーム表示用ラベル
    @IBOutlet weak var nickname: UILabel!
    // 性別表示用ラベル
    @IBOutlet weak var gender: UILabel!
    // 郵便番号表示用ラベル
    @IBOutlet weak var postcode: UILabel!
    // AppDelegate
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // 各ラベルに値を設定
        mailAddress.text = appDelegate.current_user.objectForKey("mailAddress") as? String
        nickname.text = appDelegate.current_user.objectForKey("nickname") as? String
        gender.text = appDelegate.current_user.objectForKey("gender") as? String
        postcode.text = appDelegate.current_user.objectForKey("postcode") as? String
    }
}