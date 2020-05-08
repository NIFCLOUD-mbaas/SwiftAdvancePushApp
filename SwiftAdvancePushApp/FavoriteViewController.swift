//
//  FavoriteViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
    var temporaryArray: Array<String> = []
    // AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // favoriteObjectIdTemporaryArrayにuserのお気に入り情報を設定
        appDelegate.favoriteObjectIdTemporaryArray = NCMBUser.currentUser!["favorite"]! as Array<String>
        // バックアップ
        temporaryArray = NCMBUser.currentUser!["favorite"]! as Array<String>
        // tableViewの設定
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    // favoriteTableViewのセルの表示数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUMBER_OF_SHOPS
    }
    
    // favoriteTableViewのセルの内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cellデータを取得
        let cell: CustomCell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteTableCell", for: indexPath) as! CustomCell
        // 「表示件数」＜「取得件数」の場合objectを作成
        var object: NCMBObject?
        if indexPath.row < self.appDelegate.shopList.count {
            object = self.appDelegate.shopList[indexPath.row]
        }
        // cellにデータを設定
        if let unwrapObject = object {
            cell.setCell_favorite(object: unwrapObject)
        }
        return cell
    }
    
    // 「登録」ボタン押下時の処理
    @IBAction func savefavorite(_ sender: UIButton) {
        // 【mBaaS：会員管理④】ユーザー情報の更新
        // ログイン中のユーザーを取得
        let user = NCMBUser.currentUser
        // 更新された値を設定
        user!["favorite"] = appDelegate.favoriteObjectIdTemporaryArray
        // ユーザー情報を更新
        user!.saveInBackground(callback: { result in
            switch result {
            case .success:
                // 更新に成功した場合の処理
                print("お気に入り情報更新に成功しました")
                // 3秒後にstatusLabelを空にする
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.statusLabel.text = "お気に入り情報更新に成功しました"
                    self.statusLabel.text = ""
                }
                // AppDelegateに保持していたユーザー情報の更新
                self.appDelegate.current_user = user
                // バックアップ
                self.temporaryArray = self.appDelegate.favoriteObjectIdTemporaryArray
                // 【mBaaS：プッシュ通知④】installationにユーザー情報を紐づける
                let installation = NCMBInstallation.currentInstallation
                // お気に入り情報を設定
                installation["favorite"] = self.appDelegate.favoriteObjectIdTemporaryArray
                // installation情報の更新
                installation.saveInBackground(callback: { result in
                    switch result {
                    case .success:
                        // installation更新成功時の処理
                        print("installation更新(お気に入り)に成功しました")
                    case let .failure(error):
                        // installation更新失敗時の処理
                        print("installation更新(お気に入り)に失敗しました:\(error)")
                    }
                })
                
                
            case let .failure(error):
                // 更新に失敗した場合の処理
                print("お気に入り情報更新に失敗しました:\(error)")
                
                // 3秒後にstatusLabelを空にする
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.statusLabel.text = "お気に入り情報更新に失敗しました:\(error)"
                    self.statusLabel.text = ""
                }
                // AppDelegateに保持していたユーザー情報を戻す
                user!["favorite"] = self.temporaryArray
                self.appDelegate.current_user = user
            }
        })
    }
}
