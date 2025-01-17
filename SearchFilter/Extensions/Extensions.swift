//
//  Extensions.swift
//  SearchFilter
//
//  Created by Johanes Steven on 05/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

extension UIView {
  
  func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
              paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
      
    translatesAutoresizingMaskIntoConstraints = false
      
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
    }
    
    if let bottom = bottom {
      if let paddingBottom = paddingBottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
      }
    }
    
    if let right = right {
      if let paddingRight = paddingRight {
        rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
      }
    }
    
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
}

extension UIImageView {
  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
  func downloadImage(from url: URL) {
    getData(from: url) {
     data, response, error in
     guard let data = data, error == nil else {
        return
     }
     DispatchQueue.main.async() {
        self.image = UIImage(data: data)
     }
    }
  }
}
