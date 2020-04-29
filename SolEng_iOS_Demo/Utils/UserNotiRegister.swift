//
//  UserNotiRegister.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/27.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import NotificationCenter
import SendBirdSDK


//https://dev.to/maurogarcia_19/4-steps-to-add-local-notifications-to-your-ios-app-29ph

class UserNotiRegister: NSObject {
    
    private static var sharedManager: UserNotiRegister = {
        let shared = UserNotiRegister()
        return shared
    }()

    // MARK: - Accessors
    class func shared() -> UserNotiRegister {
        return sharedManager
    }
    
    let notificationCenter = UNUserNotificationCenter.current()

    public func registUserNoti(sbMessage: SBDBaseMessage) {
        let content = UNMutableNotificationContent()
        if sbMessage is SBDUserMessage {
            let userMessage =  (sbMessage as? SBDUserMessage)
            content.title = (userMessage?.sender!.nickname)!
            content.body = (userMessage?.message)!
        } else if sbMessage is SBDFileMessage {
            let fileMessage =  (sbMessage as? SBDFileMessage)
            content.title = (fileMessage?.sender!.nickname)!
            content.body = (fileMessage?.name)!
        } else if sbMessage is SBDAdminMessage {
            return;
        }
        content.sound = UNNotificationSound.default
        
        content.userInfo = ["CustomData": "You will be able to include any kind of information here"]

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        // get the current date and time
        let currentDateTime = Date().addingTimeInterval(1)

        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]

        // get the components
        let dateTimeComponents = dateComponents.calendar!.dateComponents(requestedComponents, from: currentDateTime)

        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateTimeComponents, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.\
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
            print("added notification")
        }
    }
    
    public func removeUserNoti() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    

}
