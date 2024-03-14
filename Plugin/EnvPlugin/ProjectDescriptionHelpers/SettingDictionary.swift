//
//  SettingDictionary.swift
//  EnvPlugin
//
//  Created by Junyoung on 3/14/24.
//

import ProjectDescription

public extension SettingsDictionary {
    
    // BaseSetting
    static let baseSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited)",
            "-ObjC"
        ]
    ]
    
    // Automatic Provisioning
    func setAutomaticProvisioning() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Automatic")])
            .merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Automatic")])
    }
}
