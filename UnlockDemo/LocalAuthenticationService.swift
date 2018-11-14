//
//  LocalAuthenticationService.swift
//  UnlockDemo
//
//  Created by ZK-iOS on 2018/11/13.
//  Copyright © 2018年 ZK-iOS. All rights reserved.
//

import UIKit
import LocalAuthentication

enum BiometricsType: Int {
    case none
    case touchID
    case faceID
}

class LocalAuthenticationService: NSObject {
    
    /// 进行Face ID / Touch ID验证
    class func verifyAuthentication(with type: BiometricsType, success: @escaping () -> Void) {
        guard type != .none else {
            return
        }
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: type == .touchID ? "通过Home键验证已有手机指纹" : "面容ID") { (isSuccess, isError) in
            if isSuccess {
                success()
            }
        }
    }
    
    /// 判断是否支持Face ID / Touch ID
    class func justSupportBiometricsType() -> BiometricsType {
        let context = LAContext()
        let error: NSErrorPointer = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: error) {
            guard error == nil else {
                return .none
            }
            if #available(iOS 11.0, *) {
                return context.biometryType == .faceID ? .faceID : .touchID
            } else {
                return .touchID
            }
        }
        return .none
    }
}
