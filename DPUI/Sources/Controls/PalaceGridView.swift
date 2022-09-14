//
//  PalaceGridView.swift
//  DPUIExtensionsExample
//
//  Created by 张鹏 on 2022/6/29.
//

import Foundation
import UIKit

/// 宫格单元格
public protocol PalaceGridCell {
    var isHidden: Bool { get set }
    var frame: CGRect { get set }
    
    static func makeCell() -> Self
    
    func addToContainer(_ view: UIView)
    func removeFromContainer(_ view: UIView)
}

/// 宫格的View
open class PalaceGridView<Cell: PalaceGridCell>: UIView {
    
    // MARK: - Public Properties
    
    /// 布局
    public var layout: Layout {
        didSet {
            guard oldValue != layout else {
                return
            }
            layoutCells()
            invalidateIntrinsicContentSize()
        }
    }
    
    /// 所有的单元格，包括显示和隐藏的
    private(set) var cells: [Cell] = []
    
    /// 可见的单元格
    public var visibleCells: [Cell] {
        cells.enumerated().compactMap({
            guard $0 < layout.visibleCellCount else {
                return nil
            }
            
            return $1
        })
    }
    
    /// Cell点击的操作
    public var cellTapAction: ((Cell, Int) -> Void)?
    
    /// Cell长按的操作
    public var cellLongPressAction: ((Cell, Int) -> Void)?
    
    // MARK: - Private Properties
    
    /// 布局类型
    private var layoutCategory: Layout.Category {
        if (layout.visibleCellCount > 1) {
            return .multipleCell(maxWidth: layout.multipleCellMaxWidth)
        } else {
            return .singleCell(maxSize: layout.singleCellMaxSize)
        }
    }
    
    /// 单元格配置处理器
    private var cellSetupHandler: ((Cell, Int) -> Void)? = nil
    
    // MARK: - Life Cycle Methods
    
    public init(frame: CGRect, cellSetup: ((Cell, Int) -> Void)?) {
        self.layout = Layout(visibleCellCount: 0)
        super.init(frame: frame)
        self.cellSetupHandler = cellSetup
        setupCells()
        setupGestures()
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, cellSetup: nil)
    }
    
    required public init?(coder: NSCoder) {
        self.layout = Layout(visibleCellCount: 0)
        super.init(coder: coder)
        setupCells()
        setupGestures()
    }
    
    open override var intrinsicContentSize: CGSize {
        return layout.contentSize()
    }
    
    // MARK: - Event Methods
    
    /// 点击
    @objc
    func PalaceGridViewDidTap(_ tapGesture: UITapGestureRecognizer) {
        let tapPoint = tapGesture.location(in: self)
        for i in 0..<layout.visibleCellCount {
            let cell = cells[i]
            if cell.frame.contains(tapPoint) {
                cellTapAction?(cell, i)
                break
            }
        }
    }

    /// 长按
    @objc
    func PalaceGridViewDidLongPress(_ longPressGesture: UILongPressGestureRecognizer) {
        let tapPoint = longPressGesture.location(in: self)
        for i in 0..<layout.visibleCellCount {
            let cell = cells[i]
            if cell.frame.contains(tapPoint) {
                cellLongPressAction?(cell, i)
                break
            }
        }
    }
}

// MARK: - Helper Methods

private extension PalaceGridView {
    
    /// 配置Cell
    func setupCells() {
        
        for cell in cells {
            cell.removeFromContainer(self)
        }
        
        cells.removeAll()
        
        for index in 0..<layout.cellCount {
            let cell = Cell.makeCell()
            cell.addToContainer(self)
            cells.append(cell)
            cellSetupHandler?(cell, index)
        }
        
        layoutCells()
        
        self.clipsToBounds = true
    }
    
    /// 配置手势
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PalaceGridViewDidTap(_:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(PalaceGridViewDidLongPress(_:)))
        
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(longPressGesture)
        
        self.isUserInteractionEnabled = true
    }
    
    /// 布局Cell
    func layoutCells() {
        for cellIndex in 0..<cells.count {
            var cell = cells[cellIndex]
            if cellIndex < layout.visibleCellCount {
                cell.isHidden = false
                cell.frame = layout.cellFrame(for: cellIndex)
            } else {
                cell.isHidden = true
            }
        }
    }
}

// MARK: - Types

extension PalaceGridView {
    
    /// 宫格的布局
    public struct Layout: Equatable {
        
        /// Cell的总数量，包含隐藏的Cell
        public var cellCount: Int                = 9
        
        /// 每一行Cell的数量
        public var perRowCellCount: Int          = 3
        
        /// 可见的Cell数量
        public var visibleCellCount: Int
        
        /// 单个单元格
        public var singleCellMaxSize: CGSize     = .init(width: 280, height: 400)
        
        /// 多个单元格的最大宽度
        public var multipleCellMaxWidth: CGFloat = 300
        
        /// 单元格行间距
        public var cellSpacing: CGFloat          = 8
        
        /// 布局类型
        public var category: Category {
            if (visibleCellCount > 1) {
                return .multipleCell(maxWidth: multipleCellMaxWidth)
            } else {
                return .singleCell(maxSize: singleCellMaxSize)
            }
        }
        
        /// 单元格尺寸
        public var cellSize: CGSize {
            switch category {
            case let .singleCell(maxSize):
                return maxSize
            case let .multipleCell(maxWidth):
                let cellLength = (maxWidth - cellSpacing * CGFloat(perRowCellCount - 1)) / CGFloat(perRowCellCount)
                return CGSize(width: cellLength, height: cellLength)
            }
        }
        
        // MARK: - Life Cycle Methods
        
        public init(visibleCellCount: Int) {
            self.visibleCellCount = visibleCellCount
        }
        
        // MARK: - Features
        
        public func cellFrame(for cellIndex: Int) -> CGRect {

            let rowIndex = cellIndex / perRowCellCount
            let colIndex = cellIndex % perRowCellCount

            guard cellIndex < visibleCellCount else {
                return .zero
            }
            
            return CGRect(
                x: (cellSize.width + cellSpacing) * CGFloat(colIndex),
                y: (cellSize.height + cellSpacing) * CGFloat(rowIndex),
                width: cellSize.width,
                height: cellSize.height
            )
        }
        
        public func contentSize() -> CGSize {
            switch category {
            case .singleCell(let maxSize):
                return maxSize
            case .multipleCell:
                let cellHeight = cellSize.height
                let totalHeight = CGFloat((visibleCellCount - 1) / perRowCellCount) * (cellHeight + cellSpacing) + cellHeight
                return CGSize(width: multipleCellMaxWidth, height: totalHeight)
            }
        }
        
        // MARK: - Types
        
        /// 布局类型
        /// - singleCell: 单Cell布局
        /// - multipleCell: 多Cell布局
        public enum Category {
            case singleCell(maxSize: CGSize)
            case multipleCell(maxWidth: CGFloat)
        }
    }
}

// MARK: - UIView: PalaceGridCell

extension UIView: PalaceGridCell {
    
    public static func makeCell() -> Self {
        return Self.init(frame: .zero)
    }
    
    public func addToContainer(_ view: UIView) {
        view.addSubview(self)
    }
    
    public func removeFromContainer(_ view: UIView) {
        self.removeFromSuperview()
    }
}

// MARK: - CALayer: PalaceGridCell

extension CALayer: PalaceGridCell {
    
    public static func makeCell() -> Self {
        return Self.init()
    }
    
    public func addToContainer(_ view: UIView) {
        view.layer.addSublayer(self)
    }
    
    public func removeFromContainer(_ view: UIView) {
        self.removeFromSuperlayer()
    }
}

// MARK: - PalaceGridView where Cell: UIImageView

extension PalaceGridView where Cell: UIImageView {
    
    public func setImages(_ images: [UIImage]) {
        for i in 0..<layout.visibleCellCount {
            guard i < images.count else {
                break
            }
            
            cells[i].image = images[i]
        }
    }
}

// MARK: - PalaceGridView where Cell: ImageLayer

extension PalaceGridView where Cell: ImageLayer {
    
    public func setImages(_ images: [UIImage]) {
        for i in 0..<layout.visibleCellCount {
            guard i < images.count else {
                break
            }
            
            let cell = cells[i]
            cell.image = images[i]
        }
    }
}
