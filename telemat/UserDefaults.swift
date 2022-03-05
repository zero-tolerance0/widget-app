//
//  UserDefaults.swift
//  telemat
//
//  Created by didarmarat on 27.02.2022.
//

import Foundation

enum UserDefaultsKeys : String {
    case deviceId
    case fcmToken
    case isOpenedFromWidget
}

extension UserDefaults{

    //MARK: Save Device Id
    func setDeviceId(value: String?){
        set(value, forKey: UserDefaultsKeys.deviceId.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getDeviceId() -> String? {
        return string(forKey: UserDefaultsKeys.deviceId.rawValue) ?? nil
    }
    
    //MARK: Save Device Id
    func setIsOpenedFromWidget(value: Bool){
        set(value, forKey: UserDefaultsKeys.isOpenedFromWidget.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getIsOpenedFromWidget() -> Bool {
        return bool(forKey: UserDefaultsKeys.isOpenedFromWidget.rawValue)
    }
    
    //MARK: Save Device Id
    func setFcmToken(value: String?){
        set(value, forKey: UserDefaultsKeys.fcmToken.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getFcmToken() -> String? {
        return string(forKey: UserDefaultsKeys.fcmToken.rawValue) ?? nil
    }
}
