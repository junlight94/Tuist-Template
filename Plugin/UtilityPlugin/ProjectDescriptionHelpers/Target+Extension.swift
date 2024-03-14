//
//  Target+Extension.swift
//  UtilityPlugin
//
//  Created by Junyoung on 3/10/24.
//

import Foundation
import ProjectDescription

public extension Target {
    static func makeTarget(
        name: String,
        product: Product,
        hasResource: Bool,
        infoPlist: InfoPlist?,
        script: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings?
    ) -> Target {
        
        return .target(
            name: name,
            destinations: CommonEnviroment.destination,
            product: product,
            bundleId: CommonEnviroment.bundlePrefix,
            deploymentTargets: CommonEnviroment.deploymentTarget,
            infoPlist: infoPlist,
            sources: ["Sources/**/*.swift"],
            resources: hasResource == true ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            scripts: script,
            dependencies: dependencies,
            settings: settings
        )
    }
}

public extension Target {
    enum CommonEnviroment {
        public static let workSpaceName = "TuistTemplate"
        public static let bundlePrefix = "com.tuist.template"
        public static let deploymentTarget = DeploymentTargets.iOS("15")
        public static let destination: Set<Destination> = [.iPhone, .iPad]
    }
}
