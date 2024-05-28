// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ast2Json",
	platforms: [
		.macOS(.v13)
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
//        .library(
//            name: "Ast2Json",
//            targets: ["Ast2Json"]),
		.executable(name: "Ast2Json", targets: ["Ast2Json"])
    ],
	dependencies: [
		//.package(path: "../PyAst"),
		.package(url: "https://github.com/PythonSwiftLink/PyAst", branch: "master"),
		.package(url: "https://github.com/kylef/PathKit", .upToNextMajor(from: "1.0.1")),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Ast2Json",
			dependencies: [
				.product(name: "PyAstParser", package: "PyAst"),
				.product(name: "PyAst", package: "PyAst"),
				.product(name: "PathKit", package: "PathKit")
			]
		),
        .testTarget(
            name: "Ast2JsonTests",
            dependencies: ["Ast2Json"]),
    ]
)
