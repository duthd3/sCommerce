//
//  HomeResponse.swift
//  sCommerce
//
//  Created by yeosong on 6/1/25.
//

import Foundation

struct HomeResponse: Codable {
    let banners: [Banner]
    let horizontalProducts: [Product]
    let verticalProducts: [Product]
    let themes: [Banner]
}

struct Banner: Codable {
    let id: Int
    let imageUrl: String
}

struct Product: Codable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
