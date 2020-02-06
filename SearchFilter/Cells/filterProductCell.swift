//
//  filterProductCell.swift
//  SearchFilter
//
//  Created by Johanes Steven on 04/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

class FilterProductCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  let imageView: UIImageView = {
     let image = UIImageView()
      image.translatesAutoresizingMaskIntoConstraints = false
      image.contentMode = .scaleAspectFill
      image.clipsToBounds = true
//      image.layer.cornerRadius = 50
//      image.backgroundColor = UIColor.yellow
      return image
  }()
  
  let productNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .left
    label.textColor = .black
    label.numberOfLines = 0
    label.text = ""
//    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.7
    label.sizeToFit()
    return label
  }()
  
  let productPriceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .left
    label.textColor = .red
    label.text = ""
    return label
  }()
  
  func setupCell(){
    self.backgroundColor  = .white
    addSubview(imageView)
    addSubview(productNameLabel)
    addSubview(productPriceLabel)
      
    imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    imageView.anchor(top: self.topAnchor, paddingTop: 7.5, width: self.frame.width-15, height: self.frame.width-15)
    
    productNameLabel.anchor(top: imageView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: self.frame.height/35, paddingLeft: 15, paddingRight: 15, width: self.frame.width-15, height: self.frame.height/6)
    
    productPriceLabel.anchor(top: productNameLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: self.frame.height/40, paddingLeft: 15, paddingRight: 15, width: self.frame.width-15, height: 20)
  }
  
  func setProductDataCell(product: ProductModel) {
    productNameLabel.text = product.name
    productPriceLabel.text = product.price
    if self.frame.height > 270 {
      if let uri = product.imageURI700 {
        let url = URL(string: uri)
        self.imageView.downloadImage(from: url!)
      }
    } else {
      if let uri = product.imageURI {
        let url = URL(string: uri)
        self.imageView.downloadImage(from: url!)
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

