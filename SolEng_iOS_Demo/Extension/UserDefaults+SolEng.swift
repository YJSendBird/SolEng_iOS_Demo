//
//  UserDefaults+SolEng.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation

extension UserDefaults {

    var user: (id: String, name: String?, profile: String?) {
        get {
            let userDefault = UserDefaults.standard
            guard let userId = userDefault.value(forKey: "user.id") as? String else { return ("", nil, nil) }
            let username = userDefault.value(forKey: "user.name") as? String
            let profile = userDefault.value(forKey: "user.profile") as? String
            return (userId, username, profile)
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.setValue(newValue.id, forKey: "user.id")
            userDefault.setValue(newValue.name, forKey: "user.name")
            userDefault.setValue(newValue.profile, forKey: "user.profile")
        }
    }

    var autoLogin: Bool {
        get {
            return UserDefaults.standard.value(forKey: "com.sendbird.calls.quickstart.autologin") as? Bool ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.sendbird.calls.quickstart.autologin")
        }
    }

    var accessToken: String? {
        get {
            guard let accessToken = UserDefaults.standard.value(forKey: "com.sendbird.calls.quickstart.accesstoken") as? String else {
                return nil
            }
            return accessToken
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.sendbird.calls.quickstart.accesstoken")
        }
    }

    var voipPushToken: Data? {
        get {
            guard let pushToken = UserDefaults.standard.value(forKey: "com.sendbird.calls.quickstart.pushtoken.voip") as? Data else { return nil }
            return pushToken
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.sendbird.calls.quickstart.pushtoken.voip")
        }
    }

    var pushToken: Data? {
        get {
            guard let pushToken = UserDefaults.standard.value(forKey: "com.sendbird.calls.quickstart.pushtoken") as? Data else { return nil }
            return pushToken
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.sendbird.calls.quickstart.pushtoken")
        }
    }
    var pushTokenChange: Bool? {
        get {
            guard let pushToken = UserDefaults.standard.value(forKey: "com.sendbird.calls.quickstart.pushtokenchange") as? Bool else { return false }
            return pushToken
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.sendbird.calls.quickstart.pushtokenchange")
        }
    }
    
}

extension UserDefaults {
    func clear() {
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.appid")
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.user.id")
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.user.name")
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.user.profile")
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.autologin")
        UserDefaults.standard.removeObject(forKey: "com.sendbird.calls.quickstart.accesstoken")
    }
}
