//
//  RandomColorCasePage.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2023/4/27.
//

import UIKit
import DPUI

class RandomColorCasePage: UIViewController {

    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var randomView: UIView!
    @IBOutlet weak var makeRandomLabel: UILabel!
    @IBOutlet weak var makeRandomView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColors()
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        setupColors()
    }
    
    // MARK: - Helper Methods
    
    func setupColors() {
        randomLabel.textColor      = UIColor.dpui.random
        randomView.backgroundColor = .dpui.random
        
        makeRandomLabel.textColor      = .dpui.makeRandomColor(range: 0...0.5, alphaRange: 1...1)
        makeRandomView.backgroundColor = .dpui.makeRandomColor(range: 0...0.5, alphaRange: 1...1)
    }
}
