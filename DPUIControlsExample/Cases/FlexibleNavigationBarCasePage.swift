//
//  FlexibleNavigationBar.swift
//  DPUIControlsExample
//
//  Created by 张鹏 on 2023/4/27.
//

import UIKit
import DPUI

class FlexibleNavigationBarCasePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showButtonDidTap(_ sender: Any) {
        let presentationPage = FlexibleNavigationBarCasePresentationPage()
        
        let navigationController = UINavigationController(navigationBarClass: FlexibleNavigationBar.self, toolbarClass: UIToolbar.self)
        navigationController.setViewControllers([presentationPage], animated: false)
                
//        let navigationController = UINavigationController(rootViewController: presentationPage)
        
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.red
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.standardAppearance = appearance
        
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

// MARK: - FlexibleNavigationBarCasePresentationPage

class FlexibleNavigationBarCasePresentationPage: UIViewController {
    
    var isRootPage: Bool {
        return (self.navigationController?.viewControllers.count == 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "PresentationPage"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: isRootPage ? "关闭" : "返回",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backButtonDidTap(_:)))
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "下一页",
                            style: .plain,
                            target: self,
                            action: #selector(nextButtonDidTap(_:))),
            UIBarButtonItem(title: "变更样式",
                            style: .plain,
                            target: self,
                            action: #selector(changeButtonDidTap(_:))),
        ]
        
        self.view.backgroundColor = .dpui.makeRandomColor(range: nil, alphaRange: 1...1)
    }
    
    // MARK: - Helper Methods
    
    @objc
    func backButtonDidTap(_ sender: Any?) {
        if isRootPage {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func nextButtonDidTap(_ sender: Any?) {
        let presentationPage = FlexibleNavigationBarCasePresentationPage()
        navigationController?.pushViewController(presentationPage, animated: true)
    }
    
    @objc
    func changeButtonDidTap(_ sender: Any?) {
        
        if #available(iOS 15, *) {
            self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.blue]
            self.navigationController?.navigationBar.scrollEdgeAppearance?.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellow];
        } else {
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
            self.navigationController?.navigationBar.standardAppearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellow];
        }
    }
}
