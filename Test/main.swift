//
//  File.swift
//  
//
//  Created by zhenglicheng on 29/7/2025.
//

import Foundation
import MMKV
print("===Test===")

let dir = FileManager.default.currentDirectoryPath
MMKV.initialize(rootDir: dir)
print(dir)

let mmkv = MMKV.default()
print(String(describing: mmkv))
mmkv?.set("Hello", forKey: "Test")
let value = mmkv?.string(forKey: "Test")

print(String(describing: value))
RunLoop.main.run()
