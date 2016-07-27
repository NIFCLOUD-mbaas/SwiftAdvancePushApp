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
    // プッシュ通知で取得したペイロード
    var payloadData: AnyObject!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 【mBaaS】 APIキーの設定とSDKの初期化
        NCMB.setApplicationKey("YOUR_NCMB_APPLICATIONKEY", clientKey: "YOUR_NCMB_CLIENTKEY")
        
        
        // 【mBaaS：プッシュ通知①】デバイストークンの取得
        // デバイストークンの要求
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
            /** iOS8以上 **/
             //通知のタイプを設定したsettingを用意
            let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
            let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
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
            let payload = remoteNotification.objectForKey("deliveryTime")
            if payload != nil {
                // 値を取得した後の処理
                print("ペイロードを取得しました：\(payload)")
                // 値の取得
                payloadData = payload
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
        let payload = userInfo["deliveryTime"]
        if payload != nil {
            // 値を取得した後の処理
            print("ペイロードを取得しました：\(payload)")
            // 値の取得
            payloadData = payload
        }
    }
    
    
}