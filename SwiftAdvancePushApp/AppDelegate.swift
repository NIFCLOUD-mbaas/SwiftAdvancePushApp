//
//  AppDelegate.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // mBaaSから取得した「Shop」クラスのデータ格納用
    var shopList: Array<NCMBObject> = []
    // mBaaSから取得した「User」情報データ格納用
    var current_user: NCMBUser!
    // お気に入り情報一時格納用
    var favoriteObjectIdTemporaryArray: Array<String>!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 【mBaaS】 APIキーの設定とSDKの初期化
        NCMB.setApplicationKey("YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
        
        // 【mBaaS：プッシュ通知①】デバイストークンの取得
        
        
        // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
        
        
        return true
    }
    
    // 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
    
    
}