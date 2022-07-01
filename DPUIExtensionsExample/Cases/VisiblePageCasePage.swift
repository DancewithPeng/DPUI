//
//  VisiblePageCasePage.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2022/7/1.
//

import UIKit
import DPUI

class VisiblePageCasePage: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showVisiblePageButtonDidTap(_ sender: Any) {
        if let visiblePage = dpui.visiblePage {
            alertMessage("The Visible Page is \(visiblePage)")
        } else {
            alertMessage("Can Not Get The Visible Page")
        }
    }
    
    @IBAction func dismissButtonDidTap(_ sender: Any) {
        if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension VisiblePageCasePage {
    
    func alertMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true)
    }
}
