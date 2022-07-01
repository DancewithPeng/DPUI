//
//  PalaceGridViewCasePage.swift
//  DPUIControlsExample
//
//  Created by 张鹏 on 2022/7/1.
//

import UIKit
import DPUI

class PalaceGridViewCasePage: UIViewController {

    @IBOutlet weak var gridContainerView: UIView!
    
    lazy var gridView: PalaceGridView<ImageLayer> = {
        let gridView = PalaceGridView<ImageLayer>(frame: .zero) { cell, index in
            
        }
        
        var layout = PalaceGridView<ImageLayer>.Layout(visibleCellCount: 9)
        layout.multipleCellMaxWidth = UIScreen.main.bounds.width - 100
        gridView.layout = layout
        
        return gridView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridContainerView.addSubview(gridView)
        gridView.translatesAutoresizingMaskIntoConstraints                                 = false
        gridView.leftAnchor.constraint(equalTo: gridContainerView.leftAnchor).isActive     = true
        gridView.topAnchor.constraint(equalTo: gridContainerView.topAnchor).isActive       = true
        gridView.rightAnchor.constraint(equalTo: gridContainerView.rightAnchor).isActive   = true
        gridView.bottomAnchor.constraint(equalTo: gridContainerView.bottomAnchor).isActive = true
        
        gridView.setImages([
            .init(named: "cat-1")!,
            .init(named: "cat-2")!,
            .init(named: "cat-3")!,
            .init(named: "cat-4")!,
            .init(named: "cat-5")!,
            .init(named: "cat-6")!,
            .init(named: "cat-7")!,
            .init(named: "cat-8")!,
            .init(named: "cat-9")!,
        ])
    }
        
    @IBAction func changeCountButtonDidTap(_ sender: Any) {
        gridView.layout.visibleCellCount = Int.random(in: 1...9)
    }
    
    @IBAction func changePerRowCountButtonDidTap(_ sender: Any) {
        gridView.layout.perRowCellCount = Int.random(in: 2...6)
    }
}
