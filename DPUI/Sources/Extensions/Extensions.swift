//
//  Namespace.swift
//  DPUI
//
//  Created by 张鹏 on 2022/6/29.
//

import Foundation
import UIKit

/// 扩展
public struct Extensions<Base> {
    
    public let base: Base
    
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

/// 扩展提供者
public protocol ExtensionsProvider {}

/// 扩展的默认实现，提供`.dpui`命名空间
extension ExtensionsProvider {
    
    public var dpui: Extensions<Self> {
        return Extensions(self)
    }

    public static var dpui: Extensions<Self>.Type {
        return Extensions<Self>.self
    }
}

extension Extensions: Equatable where Base: Equatable {}
extension Extensions: Hashable where Base: Hashable {}

extension UIApplication: ExtensionsProvider {}
extension UIViewController: ExtensionsProvider {}
extension UIView: ExtensionsProvider {}
//extension UIColor: ExtensionsProvider {}
