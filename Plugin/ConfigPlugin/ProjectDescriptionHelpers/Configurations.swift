//
//  Configurations.swift
//  DependencyPlugin
//
//  Created by Junyoung on 3/13/24.
//

import Foundation
import ProjectDescription

public enum XcType: String {
    case airklass
}

public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Framework.xcconfig") }
        
        static var tests: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Tests.xcconfig") }
        
        static func project(_ config: String) -> ProjectDescription.Path { .relativeToRoot("xcconfigs/Base/Projects/Config/Project-\(config).xcconfig") }
    }
    
    public static let framework: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.framework),
        .debug(name: "TEST", xcconfig: Path.framework),
        .release(name: "PROD", xcconfig: Path.framework),
    ]
    
    public static let tests: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.tests),
        .debug(name: "TEST", xcconfig: Path.tests),
        .release(name: "PROD", xcconfig: Path.tests),
    ]
    
    public static let project: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.project("DEV")),
        .debug(name: "TEST", xcconfig: Path.project("TEST")),
        .release(name: "PROD", xcconfig: Path.project("PROD")),
    ]
}
