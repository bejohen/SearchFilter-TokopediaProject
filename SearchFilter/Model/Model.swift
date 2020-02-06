//
//  Model.swift
//  SearchFilter
//
//  Created by Johanes Steven on 05/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import Foundation

// MARK: - Datum
struct Product: Codable {
    let id: Int
    let name: String
    let uri: String
    let imageURI, imageURI700: String
    let price, priceRange, categoryBreadcrumb: String
    let shop: Shop
    let wholesalePrice: [WholesalePrice]
    let condition, preorder, departmentID, rating: Int
    let isFeatured, countReview, countTalk, countSold: Int
    let labels: [Label]
    let labelGroups, topLabel, bottomLabel: JSONNull?
    let badges: [Badge]
    let originalPrice, discountExpired, discountStart: String
    let discountPercentage, stock: Int

    enum CodingKeys: String, CodingKey {
        case id, name, uri
        case imageURI = "image_uri"
        case imageURI700 = "image_uri_700"
        case price
        case priceRange = "price_range"
        case categoryBreadcrumb = "category_breadcrumb"
        case shop
        case wholesalePrice = "wholesale_price"
        case condition, preorder
        case departmentID = "department_id"
        case rating
        case isFeatured = "is_featured"
        case countReview = "count_review"
        case countTalk = "count_talk"
        case countSold = "count_sold"
        case labels
        case labelGroups = "label_groups"
        case topLabel = "top_label"
        case bottomLabel = "bottom_label"
        case badges
        case originalPrice = "original_price"
        case discountExpired = "discount_expired"
        case discountStart = "discount_start"
        case discountPercentage = "discount_percentage"
        case stock
    }
}

// MARK: - Badge
struct Badge: Codable {
    let title: BadgeTitle
    let imageURL: String
    let show: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case show
    }
}

enum BadgeTitle: String, Codable {
    case powerBadge = "Power Badge"
}

// MARK: - Label
struct Label: Codable {
    let title: LabelTitle
    let color: Color
}

enum Color: String, Codable {
    case ffffff = "#ffffff"
    case the42B549 = "#42b549"
}

enum LabelTitle: String, Codable {
    case gratisOngkir = "Gratis Ongkir"
    case grosir = "Grosir"
}

// MARK: - Shop
struct Shop: Codable {
    let id: Int
    let name: String
    let uri: String
    let isGold: Int
    let rating: JSONNull?
    let location: City
    let reputationImageURI, shopLucky: String
    let city: City
    let isPowerBadge: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, uri
        case isGold = "is_gold"
        case rating, location
        case reputationImageURI = "reputation_image_uri"
        case shopLucky = "shop_lucky"
        case city
        case isPowerBadge = "is_power_badge"
    }
}

enum City: String, Codable {
    case jakartaBarat = "Jakarta Barat"
    case jakartaPusat = "Jakarta Pusat"
    case jakartaUtara = "Jakarta Utara"
}

// MARK: - WholesalePrice
struct WholesalePrice: Codable {
    let countMin, countMax: Int
    let price: String

    enum CodingKeys: String, CodingKey {
        case countMin = "count_min"
        case countMax = "count_max"
        case price
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
