// The Swift Programming Language
// https://docs.swift.org/swift-book
import PyAst
import PyAstParser
import Foundation
import PathKit

var args = CommandLine.arguments.dropFirst()

let in_path = Path(args.removeFirst())
let out_path: Path? = {
	if let first = args.first {
		return Path(first)
	}
	return nil
}()
var stdlib: String {
//	if let first = args.first {
//		return first
//	}
	return "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11"
}
	
PythonHandler.shared.start(stdlib: stdlib, app_packages: [], debug: true)
do {
	for file in in_path.filter({$0.extension == "py"}) {
		let module = try AST.parseString( try file.read(.utf8) )
		let jdata = try JSONEncoder().encode(module)
		let filename = file.lastComponentWithoutExtension
		if let out = out_path {
			let jpath = out + (filename + ".json")
			try jpath.write(jdata)
		} else {
			let jpath = in_path + (filename + ".json")
			try jpath.write(jdata)
		}
	}
	
}
catch let err {
	print(err)
}
	

