//
//  ViewController.swift
//  本地通知
//
//  Created by 何晓文 on 2016/11/15.
//  Copyright © 2016年 何晓文. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func showNotification(_ sender: Any) {
       //ios8 9
//        let notification = UILocalNotification()
//        
//        notification.alertBody = "顺子不要?"
//      
//        notification.fireDate = Date(timeIntervalSinceNow: 2)
//        
//        UIApplication.shared.scheduleLocalNotification(notification)
        
//        showAlert(title: "通知", message: "2s后")
        
        NotificationManager.scheduleNotification(id: "标识", title: "通知测试", subtitle: "子标题", body: "风雨一夜花满楼", badgeCount: 10)
        
        NotificationManager.pending { [weak self] value in
            print("\(value)未发送")
            self?.showAlert(title: "通知", message: "\(value)未发送")
        }
        
        NotificationManager.delivered{ [weak self] value in
              self?.showAlert(title: "通知", message: "\(value)已发送")
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

