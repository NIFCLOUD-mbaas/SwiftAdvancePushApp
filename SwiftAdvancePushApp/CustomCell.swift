//
//  CustomCell.swift
//  SwiftAdvancePushApp
//
//  Created by Natsumo Ikeda on 2016/07/14.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class CustomCell: UITableViewCell {
    /** Top画面のTableViewのcell用 **/
    // icon表示用ImageView
    @IBOutlet weak var iconImageView: UIImageView!
    // Shop名表示用ラベル
    @IBOutlet weak var shopName: UILabel!
    // カテゴリ表示用ラベル
    @IBOutlet weak var category: UILabel!
    
    /** お気に入り画面のTableViewのcell用 **/
    // Shop名表示用ラベル
    @IBOutlet weak var shopName_favorite: UILabel!
    // お気に入りON/OFF設定用スイッチ
    @IBOutlet weak var favoriteSwitch: UISwitch!
    // データ一時保管用配列（要素：{"objectId":"***", "index": "***"}）
    var temporaryArray: Array<AnyObject> = []
    
    // AppDelegate
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    /** Top画面のTableViewのcell **/
    func setCell(object: NCMBObject) {
        // 【mBaaS：ファイルストア】icon画像の取得
        let imageName = object.objectForKey("icon_image") as! String
        let imageFile = NCMBFile.fileWithName(imageName, data: nil)
        imageFile.getDataInBackgroundWithBlock { (data: NSData!, error: NSError!) -> Void in
            if error != nil {
                // ファイル取得失敗時の処理
                print("icon画像の取得に失敗しました:\(error.code)")
            } else {
                // ファイル取得成功時の処理
                print("icon画像の取得に成功しました")
                // icon画像を設定
                self.iconImageView.image = UIImage.init(data: data)
            }
        }
        // Shop名を設定
        shopName.text = object.objectForKey("name") as? String
        // categoryを設定
        category.text = object.objectForKey("category") as? String
    }
    
    /** お気に入り画面のTableViewのcell **/
    func setCell_favorite(object: NCMBObject, index: Int) {
        let objId = object.objectId
        //　Shop名を設定
        shopName_favorite.text = object.objectForKey("name") as? String
        // indexをスイッチのタグに設定
        favoriteSwitch.tag = index
        // objectIdとindexを配列として保持
        temporaryArray.append(["objectId":objId, "index":index])
        // スイッチ選択時に実行されるメソッドの設定
        favoriteSwitch.addTarget(self, action: "switchChenged:", forControlEvents: UIControlEvents.ValueChanged)
        // スイッチの初期設定
        favoriteSwitch.on = false
        // お気に入り登録されている場合はスイッチをONに設定
        let favoriteArray = appDelegate.currentUser.objectForKey("favorite") as! Array<String>
        for element in favoriteArray {
            if element == objId {
                favoriteSwitch.on = true
            }
        }
    }
    
    // スイッチ選択時の処理
    func switchChenged(sender: UISwitch) {
        var favoriteArray = appDelegate.currentUser.objectForKey("favorite") as! Array<String>
        if sender.on {
            // スイッチがONになったときの処理
            for data in temporaryArray {
                if data["index"] as! Int == sender.tag {
                    let id = data["objectId"] as! String
                    // 追加
                    favoriteArray.append(id)
                }
            }
        } else {
            // スイッチがOFFになったときの処理
            for data in temporaryArray {
                if data["index"] as! Int == sender.tag {
                    let id = data["objectId"] as! String
                    for var i = 0; i<favoriteArray.count; i++ {
                        if favoriteArray[i] == id {
                            // 削除
                            favoriteArray.removeAtIndex(i)
                        }
                    }
                }
            }
        }
        // AppDelegateに用意した一時保存用配列にを上書き
        appDelegate.favoriteTemporaryArray = favoriteArray
    }
}