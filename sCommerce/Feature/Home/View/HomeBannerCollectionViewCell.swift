//
//  HomeBannerCollectionViewCell.swift
//  sCommerce
//
//  Created by juni on 3/30/25.
//

import UIKit
import Kingfisher

struct HomeBannerCollectionViewCellViewModel: Hashable {
    let bannerImageUrl: String
}

class HomeBannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setViewModel(_ viewModel: HomeBannerCollectionViewCellViewModel) {
        //imageView.image = viewModel.bannerImage
        imageView.kf.setImage(with: URL(string: viewModel.bannerImageUrl))
    }
}

extension HomeBannerCollectionViewCell {
    static func bannerLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(165 / 393))
        
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging // 배너 페이징 하기 위함
        return section
    }
}
