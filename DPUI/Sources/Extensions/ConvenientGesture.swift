//
//  ConvenientGesture.swift
//  DPUI
//
//  Created by 张鹏 on 2023/4/14.
//

import UIKit

extension UIView {
    
    @objc
    @discardableResult
    /// 添加点击手势
    /// - Parameters:
    ///   - target: 回调的目标
    ///   - action: 回调的方法
    public func addTapGestureRecognizer(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
        return tap
    }
    
    @objc
    @discardableResult
    /// 添加长按手势
    /// - Parameters:
    ///   - target: 回调的目标
    ///   - action: 回调的方法
    public func addLongPressGestureRecognizer(target: Any?, action: Selector?) -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(longPress)
        return longPress
    }
    
    @objc
    @discardableResult
    /// 添加拖拽手势
    /// - Parameters:
    ///   - target: 回调的目标
    ///   - action: 回调的方法
    public func addPanGestureRecognizer(target: Any?, action: Selector?) -> UIPanGestureRecognizer {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(pan)
        return pan
    }
}
