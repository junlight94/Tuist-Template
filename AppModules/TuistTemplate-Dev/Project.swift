//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junyoung on 3/13/24.
//

import Foundation
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(name: "name", 
                                 target: [.app],
                                 internalDependencies: [
                                    .Features.RootFeature
                                 ])
