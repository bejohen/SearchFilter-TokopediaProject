//
//  ProductModel.swift
//  SearchFilter
//
//  Created by Johanes Steven on 05/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import Foundation

struct ProductResponse: Codable {
    let data: [ProductModel]
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


//
//enum APIError: Error, LocalizedError {
//    case unknown, apiError(reason: String)
//
//    var errorDescription: String? {
//        switch self {
//        case .unknown:
//            return "Unknown error"
//        case .apiError(let reason):
//            return reason
//        }
//    }
//}

//struct ApiService {
//
//  static func fetch(matching query: String, pmin: String, pmax: String, wholesale: String, official: String, fshop: String, start: String, rows: String) -> AnyPublisher<Data, APIError> {
//
//    guard
//      let url = URL(string: "https://ace.tokopedia.com/search/v2.5/product?q=\(query)&pmin=\(pmin)&pmax=\(pmax)&wholesale=\(wholesale)&official=\(official)&fshop=\(fshop)&start=\(start)&rows=\(rows)")
//    else {
//      preconditionFailure("Can't create url for query: \(query)")
//    }
//    let request = URLRequest(url: url)
//
//    return URLSession.shared.dataTaskPublisher(for: request)
//      .tryMap { data, response in
//        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//          throw APIError.unknown
//        }
//        return data
//      }
//      .mapError { error in
//        if let error = error as? APIError {
//          return error
//        } else {
//          return APIError.apiError(reason: error.localizedDescription)
//        }
//      }
//      .eraseToAnyPublisher()
//    }
//}

//class ApiService {
//  func fetchProduct() -> AnyPublisher<ProductResponse, Error> {
//    let url = "https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=0&rows=10"
//    
//    guard let productURL = URL(string: url) else {
//      fatalError("Invalid URL")
//    }
//    
//    return URLSession.shared.dataTaskPublisher(for: productURL)
//      .map { $0.data }
//      .decode(type: ProductResponse.self, decoder: JSONDecoder())
////      .map { $0.data }
//      .receive(on: RunLoop.main)
//      .eraseToAnyPublisher()
//  }
//}

//class ApiService {
//    private let session: URLSession
//    private let decoder: JSONDecoder
//
//    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
//        self.session = session
//        self.decoder = decoder
//    }
//}
//
//extension ApiService {
//
//  func search(matching query: String, pmin: String, pmax: String, wholesale: String, official: String, fshop: String, start: String, rows: String) -> AnyPublisher<[ProductModel], Error> {
//
//    guard
//      let url = URL(string: "https://ace.tokopedia.com/search/v2.5/product?q=\(query)&pmin=\(pmin)&pmax=\(pmax)&wholesale=\(wholesale)&official=\(official)&fshop=\(fshop)&start=\(start)&rows=\(rows)")
//    else { preconditionFailure("Can't create url for query: \(query)") }
//
//      return session.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: SearchResponse.self, decoder: decoder)
//        .map { $0.items }
//        .eraseToAnyPublisher()
//    }
//}

