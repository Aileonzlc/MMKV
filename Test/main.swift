//
//  File.swift
//  
//
//  Created by zhenglicheng on 29/7/2025.
//

import Foundation
import MMKV
print("===Test===")

let dir = "/Users/Shared/"
let group = "/Users/Shared/MMKV_Group"
MMKV.initialize(rootDir: dir, groupDir: group, logLevel: .debug)
print(dir)

let mmkv = MMKV(mmapID: "test_mmkv", mode: .multiProcess)
print(String(describing: mmkv))
mmkv?.set("Hello", forKey: "Test")
let value = mmkv?.string(forKey: "Test")

print(String(describing: value))
RunLoop.main.run()
