//
//  HomeViewModel.swift
//  sCommerce
//
//  Created by yeosong on 6/1/25.
//

import Foundation
import Combine

class HomeViewModel {
    enum Action {
        case loadData
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
        }
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case let .getDataSuccess(response):
            transformResponse(response)
        case let .getDataFailure(error):
            print("network Error: \(error)")
        }
    }
    
    private func loadData() {
        loadDataTask = Task {
            do {
                print("loadData실행")
                let response = try await NetworkService.shared.getHomeData()
                process(action: .getDataSuccess(response))
                
            } catch {
                process(action: .getDataFailure(error))
                print("network error \(error)")
            }
        }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map { bannerResponse in
            HomeBannerCollectionViewCellViewModel(bannerImageUrl: bannerResponse.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    
    private func transformResponse(_ response: HomeResponse) {
        Task {
            await transformBanner(response)
        }
        
        Task {
            await transformHorizontalProduct(response)
        }
        
        Task {
            await transformVerticalProduct(response)
        }
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ product: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        return product.map {
            HomeProductCollectionViewCellViewModel(imageUrlString: $0.imageUrl, title: $0.title, reasonDiscount: "\($0.discount)", originalPrice: $0.originalPrice.moneyString, discountPrice: $0.discountPrice.moneyString)
        }
        
    }
}
