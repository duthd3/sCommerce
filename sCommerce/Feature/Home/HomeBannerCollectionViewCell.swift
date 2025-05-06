//
//  HomeBannerCollectionViewCell.swift
//  sCommerce
//
//  Created by juni on 3/30/25.
//

import UIKit

class HomeBannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
