//
//  VisiblePage.swift
//  DPUI
//
//  Created by 张鹏 on 2022/6/29.
//

import UIKit

// MARK: - Extensions where Base: UIViewController

extension UIViewController: ExtensionsProvider {}
extension Extensions where Base: UIViewController {
    
    /// 可见页面
    public var visiblePage: UIViewController? {
        
        if let presentedViewController = base.presentedViewController {
            return presentedViewController.dpui.visiblePage
        }
        
        if let nav = base as? UINavigationController,
            let visibleViewController = nav.visibleViewController {
            return visibleViewController.dpui.visiblePage
        }
        
        if let tab = base as? UITabBarController,
           let selectedViewController = tab.selectedViewController {
            return selectedViewController.dpui.visiblePage
        }
        
        if base.isViewLoaded && base.view.isHidden == false && base.view.alpha > 0 {
            return base
        }
        
        return nil
    }
}

// MARK: - Extensions where Base: UIApplication

extension UIApplication: ExtensionsProvider {}
extension Extensions where Base: UIApplication {
        
    /// 前台激活的的Scene
    public var foregroundActiveScene: UIScene? {
        for scene in base.connectedScenes {
            guard scene.activationState == .foregroundActive else {
                continue
            }
            
            return scene
        }
        
        return nil
    }
    
    /// 可见窗口
    public var visibleWindow: UIWindow? {
        guard let windowScene = foregroundActiveScene as? UIWindowScene else {
            return nil
        }
        
        let windows = windowScene.windows.sorted(by: { $0.windowLevel >= $1.windowLevel })
        guard let visibleWindow = windows.first(where: { $0.isHidden == false }) else {
            return nil
        }
        
        return visibleWindow
    }
    
    /// 可见页面
    public var visiblePage: UIViewController? {
        visibleWindow?.rootViewController?.dpui.visiblePage
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
    var ___objc_foregroundActiveScene: UIScene? {
        dpui.foregroundActiveScene
    }
    
    /// 可见窗口
    @objc(dpui_visibleWindow)
    var ___objc_visibleWindow: UIWindow? {
        dpui.visibleWindow
    }
    
    /// 可见页面
    @objc(dpui_visiblePage)
    var ___objc_visiblePage: UIViewController? {
        dpui.visiblePage
    }
}
