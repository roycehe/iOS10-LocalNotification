# iOS10-LocalNotification
## Usage
NotificationManager 

 NotificationManager.scheduleNotification(id: "标识", title: "通知测试", subtitle: "子标题", body: "风雨一夜花满楼", badgeCount: 10)
        
        NotificationManager.pending { [weak self] value in
            print("\(value)未发送")
            self?.showAlert(title: "通知", message: "\(value)未发送")
        }
        
        NotificationManager.delivered{ [weak self] value in
              self?.showAlert(title: "通知", message: "\(value)已发送")
        } 



