//
//  NotificationManager.swift
//  本地通知
//
//  Created by 何晓文 on 2016/11/15.
//  Copyright © 2016年 何晓文. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
import Foundation
class NotificationManager: NSObject {
    // 0 通知管理单利
    static let sharedInstance = NotificationManager()
    //1创建通知
    class func scheduleNotification(id: String, title: String, subtitle: String, body: String, badgeCount: NSNumber?, userInfo: [AnyHashable: Any] = [:]) {
        
        if #available(iOS 10.0, *) {
            scheduleUNUserNotification(id: id, title: title, subtitle: subtitle, body: body, badgeCount: badgeCount, userInfo: userInfo)
        } else {
            scheduleUILocalNotification(body: body)
        }
    }
    
   
    //MARK: iOS 10 配置
    
    @available(iOS 10.0, *)
    private class func scheduleUNUserNotification(id: String, title: String, subtitle: String, body: String, badgeCount: NSNumber?, userInfo: [AnyHashable: Any] = [:]) {
        requestAuthorization { granted in
            let content = createNotificationContent(title: title, subtitle: subtitle, body: body, badgeCount: badgeCount, userInfo: userInfo)
            let trigger = createTimeIntervalNotificationTrigger()
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                // Use this block to determine if the notification request was added successfully.
                if error == nil {
                    NSLog("Notification scheduled")
                } else {
                    NSLog("Error scheduling notification")
                }
            }
        }
    }
    
    //MARK: 1.2通知授权
    @available(iOS 10.0, *)
    class func requestAuthorization(completion: ((_ granted: Bool)->())? = nil) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
            if granted {
                completion?(true)
            } else {
                center.getNotificationSettings(completionHandler: { settings in
                    if settings.authorizationStatus != .authorized {
                        //User has not authorized notifications
                    }
                    if settings.lockScreenSetting != .enabled {
                        //User has either disabled notifications on the lock screen for this app or it is not supported
                    }
                    completion?(false)
                })
            }
        }
    }
    
    
    
    //MARK: 1.3 配置通知内容
    @available(iOS 10.0, *)
    private class func createNotificationContent(title: String, subtitle: String, body: String, badgeCount: NSNumber?, userInfo: [AnyHashable: Any] = [:]) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default()
        content.badge = badgeCount
        content.userInfo = userInfo
        content.attachments = createSampleAttachments()
        
        return content
    }
  
    
 
    
    
    //MARK:触发时间 1.4.1
    @available(iOS 10.0, *)
    private class func createTimeIntervalNotificationTrigger() -> UNTimeIntervalNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    }
    //MARK:触发日期 1.4.2
    @available(iOS 10.0, *)
    private class func createCalendarNotificationTrigger() -> UNCalendarNotificationTrigger {
        var dateComponents = DateComponents()
        dateComponents.hour = 4
        dateComponents.minute = 45
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }
    //MARK:触发位置 1.4.3
    @available(iOS 10.0, *)
    private class func createLocationNotificationTrigger() -> UNLocationNotificationTrigger {
        let winnipegOfficeRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 49.878510, longitude: -97.145480), radius: 10, identifier: "R&P Winnipeg")
        return UNLocationNotificationTrigger(region: winnipegOfficeRegion, repeats: false)
    }
    //MARK: 1.5 通知图片附件
    
    @available(iOS 10.0, *)
    private class func createSampleAttachments() -> [UNNotificationAttachment] {
        if let urlPath = Bundle.main.path(forResource: "20100617172406530", ofType: "png") {
            let attachmentURL = NSURL.fileURL(withPath: urlPath)
            if let attachment = try? UNNotificationAttachment(identifier: "attachment", url: attachmentURL, options: nil) {
                return [attachment]
            }
        }
        
        return []
    }
    
    //MARK: 2 iOS9以下配置
    private class func scheduleUILocalNotification(body: String) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = Date().addingTimeInterval(20)
        localNotification.alertBody = body
        localNotification.timeZone = TimeZone.current
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    //MARK:未发送是剩余通知
    @available(iOS 10.0, *)
    class func pending(completion: @escaping (_ pendingCount: Int)->()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            completion(requests.count)
        }
    }
    
    //MARK:已发送的通知
    @available(iOS 10.0, *)
    class func delivered(completion: @escaping (_ deliveredCount: Int)->()) {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            completion(notifications.count)
        }
    }
}
extension NotificationManager:UNUserNotificationCenterDelegate{
    @available(iOS 10.0, *)
    //将要出现
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
    
    
    }
    
    //收到推送
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    @available(iOS 10.0, *)
      func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void)
    {
    
    
    }


}
