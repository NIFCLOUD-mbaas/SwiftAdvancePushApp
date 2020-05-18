//
//  ShopViewController.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class ShopViewController: UIViewController {
    // Shop画像を表示するView
    @IBOutlet weak var shopView: UIImageView!
    // お気に入りBarButtonItem
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    // Top画面のリストから取得したindex格納用
    var shopIndex: Int!
    // AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // インスタンス化された直後、初回のみ実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // 【mBaaS：ファイルストア②】Shop画像の取得
        // 取得した「Shop」クラスデータからShop画面用の画像名を取得
        let shop = appDelegate.shopList[shopIndex]
        let imageName = shop._fields["shop_image"] as! String
        // ファイル名を設定
        let imageFile = NCMBFile(fileName:imageName)
        // ファイルを検索
        imageFile.fetchInBackground(callback: { result in
            switch result {
            case let .success(data):
                // ファイル取得成功時の処理
                print("Shop画像の取得に成功しました")
                DispatchQueue.main.async {
                    // Shop画像をImageViewに設定
                    self.shopView.image = UIImage.init(data: data!)
                    // shopViewをViewに追加
                    self.view.addSubview(self.shopView)
                }
            case let .failure(error):
                // ファイル取得失敗時の処理
                print("Shop画像の取得に失敗しました:\(error)")
            }
        })
        
        // お気に入りBarButtonItemの初期設定
        favoriteBarButton.image = UIImage(named: "favorite_off") // 「♡」
        favoriteBarButton.tag = 0
        let favoriteObjectIdArray = appDelegate.current_user!["favorite"]! as Array<String>
        // お気に入り登録されている場合の設定
        for objId in favoriteObjectIdArray {
            if objId == appDelegate.shopList[shopIndex].objectId {
                favoriteBarButton.image = UIImage(named: "favorite_on") // 「♥」
                favoriteBarButton.tag = 1
            }
        }
    }
    
    // 「お気に入り」ボタン押下時の処理
    @IBAction func tapFavoriteBtn(_ sender: UIBarButtonItem) {
        var favoriteObjectIdArray = appDelegate.current_user!["favorite"]! as Array<String>
        let objeId = appDelegate.shopList[shopIndex].objectId
        // お気に入り状況に応じて処理
        if sender.tag == 0 {
            sender.image = UIImage(named: "favorite_on") // 「♥」
            sender.tag = 1
            // 追加
            favoriteObjectIdArray.append(objeId!)
        } else {
            sender.image = UIImage(named: "favorite_off") // 「♡」
            sender.tag = 0
            var i = 0
            for element in favoriteObjectIdArray {
                if element == objeId {
                    // 削除
                    favoriteObjectIdArray.remove(at: i)
                }
                i += 1
            }
        }
        // 【mBaaS：会員管理⑤】ユーザー情報の更新
        // ログイン中のユーザーを取得
        let user = NCMBUser.currentUser!
        // 更新された値を設定
        user["favorite"] = favoriteObjectIdArray
        // ユーザー情報を更新
        user.saveInBackground(callback: { result in
            switch result {
            case .success:
                // 更新に成功した場合の処理
                print("お気に入り情報更新に成功しました")
                // AppDelegateに保持していたユーザー情報の更新
                self.appDelegate.current_user = user
                // 【mBaaS：プッシュ通知⑤】installationにユーザー情報を紐づける
                let installation: NCMBInstallation? = NCMBInstallation.currentInstallation
                if installation != nil {
                    // お気に入り情報を設定
                    installation!["favorite"] = favoriteObjectIdArray
                    // installation情報の更新
                    installation!.saveInBackground(callback: { result in
                        switch result {
                        case .success:
                            // installation更新成功時の処理
                            print("installation更新(お気に入り)に成功しました")
                        case let .failure(error):
                            // installation更新失敗時の処理
                            print("installation更新(お気に入り)に失敗しました:\(error)")
                        }
                    })
                }
            case let .failure(error):
                // 更新に失敗した場合の処理
                print("お気に入り情報更新に失敗しました:\(error)")
                // お気に入り状況に応じて処理
                if sender.tag == 0 {
                    sender.image = UIImage(named: "favorite_on") // 「♥」
                    sender.tag = 1
                    // 追加
                    favoriteObjectIdArray.append(objeId!)
                } else {
                    sender.image = UIImage(named: "favorite_off") // 「♡」
                    sender.tag = 0
                    var i = 0
                    for element in favoriteObjectIdArray {
                        if element == objeId {
                            // 削除
                            favoriteObjectIdArray.remove(at: i)
                        }
                        i += 1
                    }
                }
            }
        })

    }
}
