import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin


let project = Project.makeModule(name: "TuistTemplate", // Feature, App의 이름
                                 target: [.app], // 타겟의 타입 (.app, .staticFramework, .demo, interface ... )
                                 internalDependencies: [
                                    .Features.rootFeature // 생성하는 모듈이 의존할 모듈
                                 ]
)
