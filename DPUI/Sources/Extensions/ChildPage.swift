//
//  ChildPage.swift
//  DPUI
//
//  Created by 张鹏 on 2022/7/1.
//

import Foundation
import UIKit

/// 子页面专场动画
public typealias ChildPageTransitionAnimation = (UIView, UIView, ((Bool) -> Void)?) -> Void

extension Extensions where Base: UIViewController {
    
    /// 添加子页面
    /// - Parameter childPage: 子页面
    public func addChildPage(_ childPage: UIViewController, animations: ChildPageTransitionAnimation? = nil) {
        base.addChild(childPage)
        
        base.view.addSubview(childPage.view)
        childPage.view.translatesAutoresizingMaskIntoConstraints                         = false
        childPage.view.leftAnchor.constraint(equalTo: base.view.leftAnchor).isActive     = true
        childPage.view.topAnchor.constraint(equalTo: base.view.topAnchor).isActive       = true
        childPage.view.rightAnchor.constraint(equalTo: base.view.rightAnchor).isActive   = true
        childPage.view.bottomAnchor.constraint(equalTo: base.view.bottomAnchor).isActive = true
        
        if let animations = animations {
            animations(childPage.view, base.view, { isFinished in
                childPage.didMove(toParent: base)
            })
        } else {
            childPage.didMove(toParent: base)
        }
    }
    
    /// 移除子页面
    public func removeChildPage(_ chilPage: UIViewController, animations: ChildPageTransitionAnimation? = nil) {
        chilPage.willMove(toParent: nil)
        
        if let animations = animations {
            animations(chilPage.view, base.view, { isFinished in
                chilPage.view.removeFromSuperview()
                chilPage.removeFromParent()
            })
        } else {
            chilPage.view.removeFromSuperview()
            chilPage.removeFromParent()
        }
    }
}
