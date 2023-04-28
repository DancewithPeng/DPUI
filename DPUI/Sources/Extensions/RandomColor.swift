//
//  RandomColor.swift
//  DPUI
//
//  Created by 张鹏 on 2023/4/27.
//

import UIKit

extension Extensions where Base: UIColor {
    
    /// 生成一个随机颜色
    public static var random: UIColor {
        return makeRandomColor(range: nil, alphaRange: 0.5...1)
    }
    
    /// 生成一个随机颜色
    /// - Parameters:
    ///   - range: 指定随机范围，指定为nil为`0...1`
    ///   - alphaRange: 指定透明通道随机范围，指定为nil为`0...1`
    /// - Returns: 返回随机颜色
    public static func makeRandomColor(range: ClosedRange<CGFloat>?, alphaRange: ClosedRange<CGFloat>?) -> UIColor {
        let defaultRange: ClosedRange<CGFloat> = 0...1
        return UIColor(red: .random(in: range ?? defaultRange),
                       green: .random(in: range ?? defaultRange),
                       blue: .random(in: range ?? defaultRange),
                       alpha: .random(in: alphaRange ?? defaultRange))
    }
}
