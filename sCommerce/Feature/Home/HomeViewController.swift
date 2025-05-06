//
//  HomeViewController.swift
//  sCommerce
//
//  Created by juni on 3/30/25.
//

import UIKit

class HomeViewController: UIViewController {
    // Diffable Data Soource에 필요한 섹션 타입
    enum Section: Int {
        case banner
        case horizontalProductItem
    }

    @IBOutlet weak var collectionView: UICollectionView!
    // Diffable Data Source 정의
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    
    private var compositionalLayout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .banner:
                let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(165 / 393))
                
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging // 배너 페이징 하기 위함
                return section
            case .horizontalProductItem:
                let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))
                
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous // 끊임없는 스크롤
                section.contentInsets = .init(top: 20, leading: 33, bottom: 0, trailing: 33)
                return section
            case .none: return nil
            }
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, viewModel in
            switch Section(rawValue: indexPath.section) {
            case .banner:
                guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel, let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCollectionViewCell", for: indexPath) as? HomeBannerCollectionViewCell else { return .init()}
                
                cell.setViewModel(viewModel)
                return cell
            case .horizontalProductItem:
                guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel, let cell: HomeProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionViewCell", for: indexPath) as? HomeProductCollectionViewCell else { return .init()}
                
                cell.setViewModel(viewModel)
                return cell
            case .none:
                return .init()
                
            }
           
        })
        
        var snapShot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapShot.appendSections([.banner])
        snapShot.appendItems([
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide1)),
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide2)),
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide3))], toSection: .banner)
        
        snapShot.appendSections([.horizontalProductItem])
        snapShot.appendItems([
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo1", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo2", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo3", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo4", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo5", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "", title: "nintendo6", reasonDiscount: "쿠폰할인", originalPrice: "100000", discountPrice: "80000")], toSection: .horizontalProductItem)
        
        dataSource?.apply(snapShot)
        
        collectionView.collectionViewLayout = compositionalLayout
        
    }
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
