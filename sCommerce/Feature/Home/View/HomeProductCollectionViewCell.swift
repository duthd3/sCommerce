//
//  HomeProductCollectionViewCell.swift
//  sCommerce
//
//  Created by juni on 5/6/25.
//

import UIKit
import Kingfisher

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
        productItemImageView.kf.setImage(with: URL(string: viewModel.imageUrlString))
        productTitleLabel.text = viewModel.title
        reasonDiscountLabel.text = viewModel.reasonDiscount
        originalPriceLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPrice, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        discountPriceLabel.text = viewModel.discountPrice
    }
}

extension HomeProductCollectionViewCell {
    static func horiziontalProductItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 끊임없는 스크롤
        section.contentInsets = .init(top: 20, leading: 33, bottom: 0, trailing: 33)
        section.interGroupSpacing = 10
        return section
    }
    
    static func verticalProductItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .estimated(277))
        
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(277))
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // 끊임없는 스크롤
        section.contentInsets = .init(top: 20, leading: 19, bottom: 0, trailing: 19)
        section.interGroupSpacing = 10
        return section
    }
}
