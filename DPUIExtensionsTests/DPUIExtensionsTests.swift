//
//  DPUIExtensionsTests.swift
//  DPUIExtensionsTests
//
//  Created by 张鹏 on 2022/7/1.
//

import XCTest
@testable import DPUI

class DPUIExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

/**
 // 用于测试两个两个命名空间是否一致
 func testNamespaceUse() throws {
     let p = Person(name: "张三", age: 18)
     XCTAssertEqual(p.dpui, DPUI.Extensions(p))
 }
 */
    
    /// 测试添加扩展功能
    func testNamespaceExtension() throws {
        let p = Person(name: "张三", age: 18)
        XCTAssertEqual(p.dpui.hiString(), "i am \(p.name), \(p.age) years old")
    }
}

struct Person: Equatable {
    let name: String
    let age: Int
}

extension Person: DPUI.ExtensionsProvider {}
extension DPUI.Extensions where Base == Person {
    func hiString() -> String {
        return "i am \(base.name), \(base.age) years old"
    }
}
