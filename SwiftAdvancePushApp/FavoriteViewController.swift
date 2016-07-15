//
//  FavoriteViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/06.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // お気に入り一覧表示用テーブル
    @IBOutlet weak var favoriteTableView: UITableView!
    // テーブル表示件数
    let numberOfShops = 4
    // AppDelegate
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // favoriteTemporaryArrayを空にする
        appDelegate.favoriteTemporaryArray = []
        // tableViewの設定
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    // favoriteTableViewのセルの表示数を設定
    func tableView(table: UITableView, numberOfRowsInSection section:Int) -> Int {
        return numberOfShops
    }
    
    // favoriteTableViewのセルの内容を設定
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // cellデータを取得
        let cell: CustomCell = favoriteTableView.dequeueReusableCellWithIdentifier("favoriteTableCell", forIndexPath: indexPath) as! CustomCell
        var object: NCMBObject?
        
        // 「表示件数」＜「取得件数」の場合objectを作成
        if indexPath.row < self.appDelegate.shopList.count {
            object = self.appDelegate.shopList[indexPath.row]
        }
        // cellにデータを設定
        if let unwrapObject  = object {
            cell.setCell_favorite(unwrapObject, index: indexPath.row)
        }
        return cell
    }
    
    // 「登録」ボタン押下時の処理
    @IBAction func savefavorite(sender: UIButton) {
        // 【mBaaS：会員管理】ユーザー情報の更新
        // ログイン中のユーザーを取得
        let user = NCMBUser.currentUser()
        // favoriteに更新された値を設定
        user.setObject(appDelegate.favoriteTemporaryArray, forKey: "favorite")
        // ユーザー情報を更新
        user.saveInBackgroundWithBlock { (error: NSError!) -> Void in
            if error != nil {
                // 更新に失敗した場合の処理
                print("お気に入り情報更新に失敗しました:\(error.code)")
            } else {
                // 更新に成功した場合の処理
                print("お気に入り情報更新に成功しました")
            }
        }
    }  
}