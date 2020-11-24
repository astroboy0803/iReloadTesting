//
//  TCollectionLayout.swift
//  iReloadTesting
//
//  Created by i9400506 on 2020/11/24.
//

import UIKit

internal final class TCollectionLayout: UICollectionViewFlowLayout {
    private let itemWidth: CGFloat = UIScreen.main.bounds.width - 20
    private let itemSpace: CGFloat = 10

    private var layoutInfo = [IndexPath: UICollectionViewLayoutAttributes]()

    override init() {
        super.init()
        initSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }

    private final func initSetup() {

        // 設定cell大小
        self.itemSize = CGSize(width: self.itemWidth, height: 45)

        // row(列-左右)cell間距
        self.minimumInteritemSpacing = self.itemSpace

        // grid/column(行-上下)cell間距
        self.minimumLineSpacing = self.itemSpace

        self.scrollDirection = .vertical
    }
}
