//
//  HexColorCasePage.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2023/1/17.
//

import UIKit
import DPUI

//extension Extensions where Base: UIColor {
//
//    public func myHexText() -> String {
//        return hexText
//    }
//
//    public var hexText: String {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//
//        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//
//        var ret: String = ""
//
//        ret.append(String(format: "%02X", Int(red * 255)))
//        ret.append(String(format: "%02X", Int(green * 255)))
//        ret.append(String(format: "%02X", Int(blue * 255)))
//        if (alpha > 0) {
//            ret.append(String(format: "%02X", Int(alpha * 255)))
//        }
//
//        return ret
//    }
//
//    public var hexTextWithTag: String {
//        return "#\(hexText)"
//    }
//}

/// Hex颜色用例页面
class HexColorCasePage: UIViewController {
    
    // MARK: - Properties
    
    var currentColor: UIColor = .black {
        didSet {
            guard oldValue != currentColor else {
                return
            }
            colorIndicatorView.backgroundColor = currentColor
        }
    }
    
    // MARK: - Subviews

    @IBOutlet weak var redInputTextField: UITextField!
    @IBOutlet weak var greenInputTextField: UITextField!
    @IBOutlet weak var blueInputTextField: UITextField!
    @IBOutlet weak var alphaInputTextField: UITextField!
    @IBOutlet weak var colorIndicatorView: UIView!
    
    @IBOutlet weak var showHexTextButton: UIButton!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorIndicatorView.layer.cornerRadius = 8
        colorIndicatorView.clipsToBounds = true
        colorIndicatorView.backgroundColor = currentColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap(_:))))
    }
    
    // MARK: - Event Methods
        
    @IBAction func showHexTextButtonDidTap(_ sender: Any?) {
        print(dpui.visiblePage!)
        print(currentColor)
//        print(currentColor.dpui.hexText)
//        print(currentColor.dpui.hexText)
//        print(currentColor.dpui.hexTextWithTag)
    }
    
    @objc
    func backgroundDidTap(_ sender: Any?) {
        view.endEditing(true)
    }
}

// MARK: - Notification Handlers

extension HexColorCasePage {
    
    @objc
    func textFieldTextDidChange(_ notification: Notification) {
        updateCurrentColorWithInputTextField()
    }
}

// MARK: - Helper Methods

extension HexColorCasePage {
    
    func updateCurrentColorWithInputTextField() {
        
        var red: CGFloat   = 0
        var green: CGFloat = 0
        var blue: CGFloat  = 0
        var alpha: CGFloat = 0
        
        if let redText = redInputTextField.text, let redValue = Int(redText) {
            red = CGFloat(redValue) / 255.0
        }
        
        if let greenText = greenInputTextField.text, let greenValue = Int(greenText) {
            green = CGFloat(greenValue) / 255.0
        }
        
        if let blueText = blueInputTextField.text, let blueValue = Int(blueText) {
            blue = CGFloat(blueValue) / 255.0
        }
        
        if let alphaText = alphaInputTextField.text, let alphaValue = Float(alphaText) {
            alpha = CGFloat(alphaValue)
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        currentColor = color
    }
}
