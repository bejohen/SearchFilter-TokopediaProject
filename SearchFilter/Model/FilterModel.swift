//
//  FilterModel.swift
//  SearchFilter
//
//  Created by Johanes Steven on 06/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import Foundation

struct FilterModel {
  var q: String?
  var pmin: Int?
  var pmax: Int?
  var wholesale: Bool?
  var official: Bool?
  var fshop: Bool?
}

extension FilterModel {
  
  static func setQueryItem(filterModel: FilterModel, start: Int?) -> String {
    var queryItem = "https://ace.tokopedia.com/search/v2.5/product?"
    
    if let q = filterModel.q {
      queryItem.append("q=\(q)")
    }
    
    if let pmin = filterModel.pmin {
      queryItem.append("&pmin=\(pmin)")
    }
    
    if let pmax = filterModel.pmax {
      queryItem.append("&pmax=\(pmax)")
    }
    
    if let wholesale = filterModel.wholesale {
      queryItem.append("&wholesale=\(wholesale)")
    }
    
    if let official = filterModel.official {
      queryItem.append("&official=\(official)")
    }
    
    if let fshop = filterModel.fshop {
      queryItem.append("&fshop=\(fshop)")
    }
    
    if let start = start {
      queryItem.append("&start=\(start)")
    } else {
      queryItem.append("&start=0")
    }
    
    queryItem.append("&rows=10")
    
    return queryItem
  }
}
