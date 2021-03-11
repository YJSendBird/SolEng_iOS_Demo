//
//  NotificationViewController.swift
//  SolEng_iOS_PushContent
//
//  Created by Yongjun Choi on 2020/06/05.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        
        //self.bodyText?.text = notification.request.content.body
        //self.headlineText?.text = notification.request.content.title
        
    }

}
