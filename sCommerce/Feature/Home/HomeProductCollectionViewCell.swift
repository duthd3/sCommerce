//
//  HomeProductCollectionViewCell.swift
//  sCommerce
//
//  Created by juni on 5/6/25.
//

import UIKit

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageUrlString: String
    let title: String
    let reasonDiscount: String
    let originalPrice: String
    let discountPrice: String
}

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var reasonDiscountLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productItemImageView: UIImageView! {
        didSet { // productItemImageView의 값이 변경된 직후에 호출
            productItemImageView.layer.cornerRadius = 5
        }
    }
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
        productTitleLabel.text = viewModel.title
        reasonDiscountLabel.text = viewModel.reasonDiscount
        originalPriceLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPrice, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        discountPriceLabel.text = viewModel.discountPrice
    }
}
