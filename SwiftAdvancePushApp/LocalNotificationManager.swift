//
//  LocalNotificationManager.swift
//  SwiftAdvancePushApp
//
//  Created by Natsumo Ikeda on 2016/07/27.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class LocalNotificationManager: NSObject {
    
    // ローカルプッシュを設定する
    static func scheduleLocalNotificationAtData(deliveryTime: NSDate, alertBody: String, userInfo: [NSObject: AnyObject]?) {
        // 配信時間を今より過去に設定しない
        if deliveryTime.timeIntervalSinceNow <= 0 {
            print("配信設定時間が過ぎています")
            return
        }
        // ローカルプッシュの作成
        let localNotification = UILocalNotification()
        // 表示時間の設定
        localNotification.fireDate = deliveryTime
        localNotification.timeZone = NSTimeZone.localTimeZone()
        // 表示されるメッセージの設定
        localNotification.alertBody = alertBody
        // 作成したローカルプッシュを設定
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
}

