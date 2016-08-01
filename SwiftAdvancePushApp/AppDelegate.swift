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
        // デバイストークンの要求
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
            /** iOS8以上 **/
             //通知のタイプを設定したsettingを用意
            let setting = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            //通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            //DevoceTokenを要求
            application.registerForRemoteNotifications()
        }else{
            /** iOS8未満 **/
            let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
        }
        
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
            NCMBPush.handleRichPush(remoteNotification as [NSObject : AnyObject])
            
            // 【mBaaS：プッシュ通知⑦】アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する
            // プッシュ通知情報の取得
            if let deliveryTime = remoteNotification.objectForKey("deliveryTime") as? String {
                if let message = remoteNotification.objectForKey("message") as? String {
                    // ローカルプッシュ配信
                    localNotificationDeliver(deliveryTime, message: message)
                }
                
            }
        }
        
        return true
    }
    
    // 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        // 端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation = NCMBInstallation.currentInstallation()
        // デバイストークンの設定
        installation.setDeviceTokenFromData(deviceToken)
        // 端末情報をデータストアに登録
        installation.saveInBackgroundWithBlock { (error: NSError!) -> Void in
            if (error != nil){
                // 端末情報の登録に失敗した時の処理
                print("デバイストークン取得に失敗しました:\(error.code)")
            }else{
                // 端末情報の登録に成功した時の処理
                print("デバイストークン取得に成功しました")
            }
        }
    }
    
    // 【mBaaS：プッシュ通知⑧】アプリが起動中にプッシュ通知の情報（ペイロード）からデータを取得する
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // プッシュ通知情報の取得
        let deliveryTime = userInfo["deliveryTime"] as! String
        let message = userInfo["message"] as! String
        // 値を取得した後の処理
        if !deliveryTime.isEmpty && !message.isEmpty  {
            print("ペイロードを取得しました：deliveryTime[\(deliveryTime)],message[\(message)]")
            // ローカルプッシュ配信
            localNotificationDeliver(deliveryTime, message: message)
        }
    }
    
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
        // 配信時間(String→NSDate)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let deliveryTime = formatter.dateFromString(deliveryTime)
        LocalNotificationManager.scheduleLocalNotificationAtData(deliveryTime!, alertBody: message, userInfo: nil)
    }    
}