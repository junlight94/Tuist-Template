//
//  Dependency+Project.swift
//  DependencyPlugin
//
//  Created by Junyoung on 3/14/24.
//

import ProjectDescription

public typealias Dep = TargetDependency

public extension Dep {
    struct Features {
        
    }
    
    struct Modules {
        
    }
}

public extension Dep.Features {
    static func project(name: String, group: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }
    
    static let rootFeature = TargetDependency.project(target: "RootFeature", path: .relativeToFeature("RootFeature"))
}

public extension Path {
    
    static func relativeToFeature(_ path: String) -> Self {
        return .relativeToRoot("Projects/Features/\(path)")
    }
    
    static func relativeToModules(_ path: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(path)")
    }
    
    static var app: Self {
        return .relativeToRoot("Projects/AppModuls/")
    }
}
