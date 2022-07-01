//
//  ImageLayerCasePage.swift
//  DPUIControlsExample
//
//  Created by 张鹏 on 2022/7/1.
//

import UIKit
import DPUI

class ImageLayerCasePage: UIViewController {
    
    var imageLayer: ImageLayer?
    
    lazy var images: [UIImage] = [
        .init(named: "cat-1")!,
        .init(named: "cat-2")!,
        .init(named: "cat-3")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func loadImageButtonDidTap(_ sender: Any) {
        
        guard imageLayer == nil else {
            return
        }

        let imageLayer = ImageLayer()
        imageLayer.frame = CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width-100, height: 200)
        imageLayer.image = images.randomElement()
        view.layer.addSublayer(imageLayer)
        self.imageLayer = imageLayer
    }
    
    @IBAction func changeImageButtonDidTap(_ sender: Any) {
        imageLayer?.image = images.randomElement()
    }
    
    
}
