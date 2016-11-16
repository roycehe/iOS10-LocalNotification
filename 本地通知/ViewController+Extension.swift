//
//  ViewController+Extension.swift
//  本地通知
//
//  Created by 何晓文 on 2016/11/15.
//  Copyright © 2016年 何晓文. All rights reserved.
//
//alert扩展
import UIKit
extension UIViewController {
    func showAlert(title:String, message:String){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
