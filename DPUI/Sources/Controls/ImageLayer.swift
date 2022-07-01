//
//  ImageLayer.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2022/6/29.
//

import Foundation
import UIKit

/// 图片层，用于直接显示图片的CALayer对象
open class ImageLayer: CALayer {
    
    public var image: UIImage? {
        didSet {
            guard oldValue != image else {
                return
            }
            self.contents = image?.cgImage
        }
    }
    
    public override init() {
        super.init()
        setupProperties()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
        setupProperties()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProperties()
    }
    
    private func setupProperties() {
        self.contentsGravity = .resizeAspectFill
        self.masksToBounds   = true
        self.contentsScale   = UIScreen.main.scale
    }
}


