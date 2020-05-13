//
//  AppDelegate.swift
//  SwiftAdvancePushApp
//
//  Created by Ikeda Natsumo on 2016/07/16.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    var window: UIWindow?
    // mBaaSから取得した「Shop」クラスのデータ格納用
    var shopList: Array<NCMBObject> = []
    // mBaaSから取得した「User」情報データ格納用
    var current_user: NCMBUser!
    // お気に入り情報一時格納用
    var favoriteObjectIdTemporaryArray: Array<String>!
    
    // APIキーの設定
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // SDKの初期化
        NCMB.initialize(applicationKey: applicationkey, clientKey: clientkey)
        
        // 【mBaaS：プッシュ通知①】デバイストークンの取得
        // デバイストークンの要求
        registerForPushNotifications()
        
        // 【mBaaS：プッシュ通知⑥】リッチプッシュ通知を表示させる処理
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            NCMBPush.handleRichPush(userInfo: notification)
            // 【mBaaS：プッシュ通知⑧】アプリが起動されたときにプッシュ通知の情報（ペイロード）からデータを取得する
            // プッシュ通知情報の取得
            if let deliveryTime = notification["deliveryTime"] as? String {
                if let message = notification["message"] as? String {
                    // ローカルプッシュ配信
                    localNotificationDeliver(deliveryTime: deliveryTime, message: message)
                }
            }
        }
        
        return true
    }
    
    // 【mBaaS：プッシュ通知②】デバイストークンの取得後に呼び出されるメソッド
    // デバイストークンが取得されたら呼び出されるメソッド
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        let installation = NCMBInstallation()
        installation.setDeviceTokenFromData(data: deviceToken)
        installation.saveInBackground { (error) in
            
        }
    }
    
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // プッシュ通知情報の取得
        if let deliveryTime = userInfo["deliveryTime"] as? String {
            if let message = userInfo["message"] as? String {
                // 値を取得した後の処理
                print("ペイロードを取得しました：deliveryTime[\(deliveryTime)],message[\(message)]")
                // ローカルプッシュ配信
                localNotificationDeliver(deliveryTime: deliveryTime, message: message)
            }
        }
        
        if let notiData = userInfo as? [String : AnyObject] {
            NCMBPush.handleRichPush(userInfo: notiData)
        }
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                print("Permission granted: \(granted)") // 3
                guard granted else { return }
                self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    // LocalNotification配信
    func localNotificationDeliver (deliveryTime: String, message: String) {
        // 配信時間(String→NSDate)を設定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let deliveryTime = formatter.date(from: deliveryTime)
        // ローカルプッシュを作成
        LocalNotificationManager.scheduleLocalNotificationAtData(deliveryTime: deliveryTime! as NSDate, alertBody: message, userInfo: nil)
    }
}
