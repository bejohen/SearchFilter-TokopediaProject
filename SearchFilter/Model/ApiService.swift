//
//  ApiService.swift
//  SearchFilter
//
//  Created by Johanes Steven on 05/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import Foundation
import Combine

class ApiService {
  
  func fetchProduct() -> AnyPublisher<[ProductModel], Error> {
        
    let url = "https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=0&rows=10"
      
  
    guard let productURL = URL(string: url) else {
        fatalError("Invalid URL")
    }
    
    return URLSession.shared.dataTaskPublisher(for: productURL)
        .map { $0.data }
        .decode(type: ProductResponse.self, decoder: JSONDecoder())
        .map { $0.data }
        .receive(on: RunLoop.main)
          .eraseToAnyPublisher()
        
  }
    
  func fetchProduct(query: String, pmin: String, pmax: String, wholesale: String, official: String, fshop: String, start: String, rows: String) -> AnyPublisher<[ProductModel], Error> {
      
    let url = "https://ace.tokopedia.com/search/v2.5/product?q=\(query)&pmin=\(pmin)&pmax=\(pmax)&wholesale=\(wholesale)&official=\(official)&fshop=\(fshop)&start=\(start)&rows=\(rows)"
    
    guard let productURL = URL(string: url) else {
        fatalError("Invalid URL")
    }
    
    return URLSession.shared.dataTaskPublisher(for: productURL)
        .map { $0.data }
        .decode(type: ProductResponse.self, decoder: JSONDecoder())
        .map { $0.data }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    
  }
  
  func scrollProduct(start: Int) -> AnyPublisher<[ProductModel], Error> {
    
    let url = "https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=\(start)&rows=10"
    
    guard let productURL = URL(string: url) else {
        fatalError("Invalid URL")
    }
    
    return URLSession.shared.dataTaskPublisher(for: productURL)
        .map { $0.data }
        .decode(type: ProductResponse.self, decoder: JSONDecoder())
        .map { $0.data }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    
  }
    
}
