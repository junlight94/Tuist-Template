//
//  FeatureTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by Junyoung Lee on 2023/08/11.
//

import ProjectDescription

public enum FeatureTarget: CaseIterable {
    case app                // App
    case interface          // Feature Interface
    case demo               // Demo App
    case testing            // Testing 모듈
    case tests              // Test 모듈
    case dynamicFramework   // DynamicFramework
    case staticFramework    // StaticFramework
    
    // 프레임워크인지 여부를 확인하기 위한 계산속성
    public var isFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
}
