//
//  FlexibleNavigationBar.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2023/4/27.
//

import UIKit

/// 灵活的导航栏
///
/// 支持以下功能
/// - 背景透明度设置
public class FlexibleNavigationBar: UINavigationBar {
    
    // MARK: - Subviews
    
    // 灵活的背景视图
    public var flexibleBackgroundView: UIView?
    
    // MARK: - Life Cycle Methods
    
    public override func pushItem(_ item: UINavigationItem, animated: Bool) {
        super.pushItem(item, animated: animated)
    }
    
    public override func popItem(animated: Bool) -> UINavigationItem? {
        return super.popItem(animated: animated)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension Extensions where Base: UINavigationBar {
    
}

extension UIBarButtonItem: ExtensionsProvider {}
