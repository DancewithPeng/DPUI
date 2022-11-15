//
//  VisiblePage.swift
//  DPUI
//
//  Created by 张鹏 on 2022/6/29.
//

import UIKit

// MARK: - VisiblePageProvider

/// 可见页提供者
public protocol VisiblePageProvider {
    var dpuiVisiblePage: UIViewController? { get }
}

// MARK: - Extensions where Base: UIViewController

extension Extensions where Base: UIViewController {
    
    /// 可见页面
    public var visiblePage: UIViewController? {
        
        if let presentedViewController = base.presentedViewController {
            return presentedViewController.dpui.visiblePage
        }
        
        if let visiblePageProvider = base as? VisiblePageProvider {
            return visiblePageProvider.dpuiVisiblePage
        }
        
        for child in base.children {
            guard let childVisiblePage = child.dpui.visiblePage else {
                continue
            }
            return childVisiblePage
        }
        
        if base.isViewLoaded && base.view.isHidden == false && base.view.alpha > 0 {
            return base
        }
        
        return nil
    }
}

// MARK: - Extensions where Base: UIApplication

extension Extensions where Base: UIApplication {
        
    /// 前台激活的的Scene
    public var foregroundActiveScene: UIScene? {
        for scene in base.connectedScenes {
            guard scene.activationState == .foregroundActive else {
                continue
            }
            
            return scene
        }
        
        return base.connectedScenes.first
    }
    
    /// 可见窗口
    public var visibleWindow: UIWindow? {
        guard let windowScene = foregroundActiveScene as? UIWindowScene else {
            return nil
        }
        
        let windows = windowScene.windows.sorted(by: { $0.windowLevel >= $1.windowLevel })

        if let keyWindow = windows.first(where: { $0.isKeyWindow }) {
            return keyWindow
        }
        
        guard let visibleWindow = windows.first(where: { $0.isHidden == false }) else {
            return nil
        }
        
        return visibleWindow
    }
    
    /// 主窗口
    public var keyWindow: UIWindow? {
        guard let windowScene = foregroundActiveScene as? UIWindowScene else {
            return nil
        }
        
        return windowScene.windows.first(where: { $0.isKeyWindow })
    }
    
    /// 所有的窗口
    public var windows: [UIWindow]? {
        guard let windowScene = foregroundActiveScene as? UIWindowScene else {
            return nil
        }
        
        return windowScene.windows
    }
    
    /// 可见页面
    public var visiblePage: UIViewController? {
        visibleWindow?.rootViewController?.dpui.visiblePage
    }
}

// MARK: - UITabBarController: VisiblePageProvider

extension UITabBarController: VisiblePageProvider {
    
    public var dpuiVisiblePage: UIViewController? {
        return selectedViewController?.dpui.visiblePage
    }
}

// MARK: - UINavigationController: VisiblePageProvider

extension UINavigationController: VisiblePageProvider {
    
    public var dpuiVisiblePage: UIViewController? {
        return visibleViewController?.dpui.visiblePage
    }
}

// MARK: - ObjC Side

extension UIViewController {
    
    @objc(dpui_visiblePage)
    public var ___objc_visiblePage: UIViewController? {
        return dpui.visiblePage
    }
}

extension UIApplication {
    
    /// 前台激活的的Scene
    @objc(dpui_foregroundActiveScene)
    public var ___objc_foregroundActiveScene: UIScene? {
        dpui.foregroundActiveScene
    }
    
    /// 可见窗口
    @objc(dpui_visibleWindow)
    public var ___objc_visibleWindow: UIWindow? {
        dpui.visibleWindow
    }
    
    /// 主窗口
    @objc(dpui_keyWindow)
    public var ___objc_keyWindow: UIWindow? {
        dpui.keyWindow
    }
    
    /// 可见页面
    @objc(dpui_visiblePage)
    public var ___objc_visiblePage: UIViewController? {
        dpui.visiblePage
    }
}
