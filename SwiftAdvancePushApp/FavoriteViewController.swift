//
//  FavoriteViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // お気に入り一覧表示用テーブル
    @IBOutlet weak var favoriteTableView: UITableView!
    // ステータス表示用ラベル
    @IBOutlet weak var statusLabel: UILabel!
    // テーブル表示件数
    let NUMBER_OF_SHOPS = 4
    // 変更前のお気に入り情報保管用
    var temporaryArray: Array<String>!
    // AppDelegate
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // favoriteObjectIdTemporaryArrayにuserのお気に入り情報を設定
        appDelegate.favoriteObjectIdTemporaryArray = appDelegate.current_user.objectForKey("favorite") as! Array<String>
        // バックアップ
        temporaryArray = appDelegate.current_user.objectForKey("favorite") as! Array<String>
        // tableViewの設定
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    // favoriteTableViewのセルの表示数を設定
    func tableView(table: UITableView, numberOfRowsInSection section:Int) -> Int {
        return NUMBER_OF_SHOPS
    }
    
    // favoriteTableViewのセルの内容を設定
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // cellデータを取得
        let cell: CustomCell = favoriteTableView.dequeueReusableCellWithIdentifier("favoriteTableCell", forIndexPath: indexPath) as! CustomCell
        // 「表示件数」＜「取得件数」の場合objectを作成
        var object: NCMBObject?
        if indexPath.row < self.appDelegate.shopList.count {
            object = self.appDelegate.shopList[indexPath.row]
        }
        // cellにデータを設定
        if let unwrapObject = object {
            cell.setCell_favorite(unwrapObject)
        }
        return cell
    }
    
    // 「登録」ボタン押下時の処理
    @IBAction func savefavorite(sender: UIButton) {
        // 【mBaaS：会員管理④】ユーザー情報の更新
        // ログイン中のユーザーを取得
        let user = NCMBUser.currentUser()
        // 更新された値を設定
        user.setObject(appDelegate.favoriteObjectIdTemporaryArray, forKey: "*****お気に入り情報*****")
        // ユーザー情報を更新
        user.saveInBackgroundWithBlock { (error: NSError!) -> Void in
            if error != nil {
                // 更新に失敗した場合の処理
                print("お気に入り情報更新に失敗しました:\(error.code)")
                self.statusLabel.text = "お気に入り情報更新に失敗しました:\(error.code)"
                // 3秒後にstatusLabelを空にする
                let deley = 3 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(deley))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.statusLabel.text = ""
                })
                // AppDelegateに保持していたユーザー情報を戻す
                user.setObject(self.temporaryArray, forKey: "favorite")
                self.appDelegate.current_user = user
            } else {
                // 更新に成功した場合の処理
                print("お気に入り情報更新に成功しました")
                self.statusLabel.text = "お気に入り情報更新に成功しました"
                // 3秒後にstatusLabelを空にする
                let deley = 3 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(deley))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.statusLabel.text = ""
                })
                // AppDelegateに保持していたユーザー情報の更新
                self.appDelegate.current_user = user
                // バックアップ
                self.temporaryArray = self.appDelegate.favoriteObjectIdTemporaryArray
                // 【mBaaS：プッシュ通知④】installationにユーザー情報を紐づける
                let installation: NCMBInstallation? = NCMBInstallation.currentInstallation()
                if installation != nil {
                    // お気に入り情報を設定
                    installation!.setObject(self.appDelegate.favoriteObjectIdTemporaryArray, forKey: "favorite")
                    // installation情報の更新
                    installation!.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
                        if error != nil {
                            // installation更新失敗時の処理
                            print("installation更新(お気に入り)に失敗しました:\(error.code)")
                        } else {
                            // installation更新成功時の処理
                            print("installation更新(お気に入り)に成功しました")
                        }
                    })
                }
            }
        }
    }
}