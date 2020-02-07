//
//  ProductModel.swift
//  SearchFilter
//
//  Created by Johanes Steven on 05/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import Foundation

struct ProductResponse: Codable {
  let header: HeaderModel
  let data: [ProductModel]
}

struct HeaderModel: Codable {
  let totalData: Int?
  let totalDataNoCategory: Int?
}

struct ProductModel: Codable {
  let id: Int?
  let name: String?
  let uri: String?
  let imageURI, imageURI700: String?
  let price, priceRange, categoryBreadcrumb: String?
  
  static var placeholder: ProductModel {
    return ProductModel(id: nil, name: nil, uri: nil, imageURI: nil, imageURI700: nil, price: nil, priceRange: nil, categoryBreadcrumb: nil)
  }
  enum CodingKeys: String, CodingKey {
    case id, name, uri
    case imageURI = "image_uri"
    case imageURI700 = "image_uri_700"
    case price
    case priceRange = "price_range"
    case categoryBreadcrumb = "category_breadcrumb"
  }
}
