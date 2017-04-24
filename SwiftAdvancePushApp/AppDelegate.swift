//
//  AppDelegate.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
        
        
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            print(remoteNotification)
            // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
            
            
            // 【mBaaS：プッシュ通知⑧】アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する
            
            
        }
        
        return true
    }
    
    // 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
    
    
    // 【mBaaS：プッシュ通知⑦】アプリが起動中にプッシュ通知の情報（ペイロード）からデータを取得する
    
    
    // プッシュ通知が許可された場合に呼ばれるメソッド
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        let allowedType = notificationSettings.types
        switch allowedType {
        case UIUserNotificationType.None:
            print("端末側でプッシュ通知が拒否されました")
        default:
            print("端末側でプッシュ通知が許可されました")
        }
    }
    
    // LocalNotification配信
    func localNotificationDeliver (deliveryTime: String, message: String) {
        // 配信時間(String→NSDate)を設定
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let deliveryTime = formatter.dateFromString(deliveryTime)
        // ローカルプッシュを作成
        LocalNotificationManager.scheduleLocalNotificationAtData(deliveryTime!, alertBody: message, userInfo: nil)
    }
}
