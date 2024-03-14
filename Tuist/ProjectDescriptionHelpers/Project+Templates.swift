import Foundation
import ProjectDescription
import DependencyPlugin
import EnvPlugin
import ConfigPlugin
import UtilityPlugin

public extension Project {
    
    // Project에서 모듈을 생성하는 static 함수
    static func makeModule(
        name: String,
        target: Set<FeatureTarget>,
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
        externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
        interfaceDependencies: [TargetDependency] = [], // Feature Interface 의존성
        dependencies: [TargetDependency] = [],
        hasResourse: Bool = false
    ) -> Project {
        
        var projectTargets: [Target] = []
        var configurationName: ConfigurationName = "DEV"
        var configuration = XCConfig.project
        let baseSettings: SettingsDictionary = .baseSettings
        
        // MARK: - AppModule
        if target.contains(.app) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            if name.contains("Prod") {
                configurationName = "PROD"
            } else if name.contains("Test") {
                configurationName = "TEST"
            }
            
            projectTargets.append(.makeTarget(name: name,
                                              product: .app,
                                              hasResource: hasResourse,
                                              infoPlist: .extendingDefault(with: Project.infoPlist),
                                              script: [],
                                              dependencies: [
                                                internalDependencies,
                                                externalDependencies
                                              ].flatMap { $0 },
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Demo Module
        if target.contains(.demo) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            // MicroFeature에서 DemoApp은 Feautre, Testing 파일을 의존하기 때문에 두 모듈을 의존하게 해줍니다
            let dependencies: [TargetDependency] = [
                .target(name: name, condition: .none),
                .target(name: name + "Testing", condition: .none)
            ]
            
            projectTargets.append(.makeTarget(name: name,
                                              product: .app,
                                              hasResource: hasResourse,
                                              infoPlist: .default,
                                              script: [],
                                              dependencies: dependencies,
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Tests Module
        if target.contains(.tests) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            // MicroFeature에서 Tests은 Demo와 동일하게 Feautre, Testing 파일을 의존하기 때문에 두 모듈을 의존하게 해줍니다
            let dependencies: [TargetDependency] = [
                .target(name: "\(name)Testing"),
                .target(name: "\(name)")
            ]
            
            projectTargets.append(.makeTarget(name: name,
                                              product: .unitTests,
                                              hasResource: hasResourse,
                                              infoPlist: .extendingDefault(with: Project.infoPlist),
                                              script: [],
                                              dependencies: dependencies,
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Testing Module
        if target.contains(.testing) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            // MicroFeature에서 Testing은 Interface 모듈만을 의존합니다
            let dependencies: [TargetDependency] = [
                .target(name: "\(name)Interface")
            ]
            
            projectTargets.append(.makeTarget(name: name,
                                              product: .app,
                                              hasResource: hasResourse,
                                              infoPlist: .extendingDefault(with: Project.infoPlist),
                                              script: [],
                                              dependencies: dependencies,
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Interface Module
        if target.contains(.interface) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            // MicroFeature에서 Interface는 한 Feature의 최하위입니다.
            projectTargets.append(.makeTarget(name: name,
                                              product: .app,
                                              hasResource: hasResourse,
                                              infoPlist: .extendingDefault(with: Project.infoPlist),
                                              script: [],
                                              dependencies: interfaceDependencies,
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Framework Source
        if target.contains(where: { $0.isFramework }) {
            let setting = baseSettings.setAutomaticProvisioning()
            
            let dependencies = internalDependencies + externalDependencies
            
            projectTargets.append(.makeTarget(name: name,
                                              product: .framework,
                                              hasResource: hasResourse,
                                              infoPlist: .default,
                                              script: [],
                                              dependencies: dependencies,
                                              settings: .settings(base: setting,
                                                                  configurations: configuration)
                                             )
            )
        }
        
        // MARK: - Return Project
        return Project(
            name: name,
            organizationName: AppEnvironment.workspaceName,
            packages: packages,
            settings: nil,
            targets: projectTargets,
            schemes: [Scheme.makeScheme(configs: configurationName, name: name)]
        )
    }
}
