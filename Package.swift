// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
 * Tencent is pleased to support the open source community by making
 * MMKV available.
 *
 * Copyright (C) 2020 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import PackageDescription

let package = Package(
    name: "MMKV",
    platforms: [
        .macOS(.v10_14),
    ],
    products: [
        .library(
            name: "MMKVCore",
            targets: ["MMKVCore"]),
        .library(
            name: "MMKV",
            targets: ["MMKV"]),
        .executable(
            name: "Test",
            targets: ["Test"]
        )
    ],
    targets: [
        .target(
            name: "Test",
            dependencies: ["MMKV"],
            path: "Test"
        ),
        .target(
            name: "MMKVCore",
            dependencies: ["MMKVCoreOpenSSLASM"],
            path: "Core",
            exclude: [
                "crc32",
                "CMakeLists.txt",
                "core.vcxproj",
                "core.vcxproj.filters",
                "Core.xcodeproj",
                "core.vcxproj.filters",
                "aes/openssl/openssl_aes-armv4.S",
                "aes/openssl/openssl_aesv8-armx.S"
            ],
            sources: [
                ".",
            ],
            publicHeadersPath: "include",
            cSettings : [
                .headerSearchPath("."),
                .headerSearchPath("aes"),
                .headerSearchPath("aes/openssl"),
                .define("DEBUG", to: "1", .when(configuration: .debug)),
                .define("NDEBUG", to: "1", .when(configuration: .release)),
            ],
            cxxSettings: [
                .headerSearchPath("."),
                .headerSearchPath("aes"),
                .headerSearchPath("aes/openssl"),
                .unsafeFlags(["-x", "objective-c++", "-fno-objc-arc"]),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "MMKVCoreOpenSSLASM",
            path: "Core/aes/openssl",
            sources: [
                "openssl_aes-armv4.S",
                "openssl_aesv8-armx.S"
            ],
            publicHeadersPath: ".",
            cSettings : [
                .define("DEBUG", to: "1", .when(configuration: .debug)),
                .define("NDEBUG", to: "1", .when(configuration: .release)),
            ]
        ),
        .target(
            name: "MMKV",
            dependencies: ["MMKVCore"],
            path: "iOS/MMKV/MMKV",
            exclude: ["Resources"],
            publicHeadersPath: ".",
            cSettings : [
                .define("DEBUG", to: "1", .when(configuration: .debug)),
                .define("NDEBUG", to: "1", .when(configuration: .release)),
            ],
            cxxSettings: [
                .headerSearchPath("."),
                .unsafeFlags(["-x", "objective-c++", "-fno-objc-arc"]),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("Foundation"),
            ]
         ),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx1z
)
