//
//  CXProvider.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/13.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import CallKit
import UIKit

extension CXProviderConfiguration {
    // The app's provider configuration, representing its CallKit capabilities
    static var `default`: CXProviderConfiguration {
        let providerConfiguration = CXProviderConfiguration(localizedName: "SendBird Calls")
        if let image = UIImage(named: "icCallkitSb") {
            providerConfiguration.iconTemplateImageData = image.pngData()
        }
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.generic]
        
        return providerConfiguration
    }
}

extension CXProvider {
    static var `default`: CXProvider {
        return CXProvider(configuration: .`default`)
    }
}
