//
//  LocalNotificationManager.swift
//  SwiftAdvancePushApp
//
//  Created by Natsumo Ikeda on 2016/07/27.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB
import UserNotifications

class LocalNotificationManager: NSObject {
    
    // ローカルプッシュを設定する
    static func scheduleLocalNotificationAtData(deliveryTime: NSDate, alertBody: String, userInfo: [NSObject: AnyObject]?) {
        // 配信時間を今より過去に設定しない
        if deliveryTime.timeIntervalSinceNow <= 0 {
            print("配信設定時間が過ぎています")
            return
        }
        // ローカルプッシュの作成
        let content = UNMutableNotificationContent()
        content.body = alertBody
        content.sound = UNNotificationSound.default

        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: deliveryTime.timeIntervalSinceNow, repeats: true)
        let request = UNNotificationRequest.init(identifier: "scheduleNof", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}

