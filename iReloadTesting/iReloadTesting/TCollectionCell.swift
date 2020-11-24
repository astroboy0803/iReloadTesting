//
//  TCollectionCell.swift
//  iReloadTesting
//
//  Created by i9400506 on 2020/11/24.
//

import UIKit

protocol TCellViewModelable {
    var text: String? { get set }
}

internal final class TCollectionCell: UICollectionViewCell {
    
    @IBOutlet private var textLabel: UILabel?
    
    final func setupCell(viewModel: TCellViewModelable) {
        self.textLabel?.text = viewModel.text
    }
}
