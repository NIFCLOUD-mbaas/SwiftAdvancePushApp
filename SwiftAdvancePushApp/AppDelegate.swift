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
    // 【mBaaS】 APIキーの設定
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"
    // mBaaSから取得した「Shop」クラスのデータ格納用
    var shopList: Array<NCMBObject> = []
    // mBaaSから取得した「User」情報データ格納用
    var current_user: NCMBUser!
    // お気に入り情報一時格納用
    var favoriteObjectIdTemporaryArray: Array<String>!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 【mBaaS】SDKの初期化
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        
        // 【mBaaS：プッシュ通知④】デバイストークンの取得
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
        // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            print(remoteNotification)
            NCMBPush.handleRichPush(remoteNotification as [NSObject : AnyObject])
        }
        
        return true
    }
    
    // 【mBaaS：プッシュ通知⑤】デバイストークンの取得後に呼び出されるメソッド
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
}