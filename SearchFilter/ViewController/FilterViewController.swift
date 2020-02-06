//
//  FilterViewController.swift
//  SearchFilter
//
//  Created by Johanes Steven on 06/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

  let scrollView: UIScrollView = {
    let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return view
  }()
  
  let priceSliderCell: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.backgroundColor = .white
    return view
  }()
  
  let minimumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 10)
    label.textAlignment = .left
    label.text = "Minimum price"
    return label
  }()
  
  let maximumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 10)
    label.textAlignment = .right
    label.text = "Maximum price"
    return label
  }()
  
  func setNavigationBarItem() {

    let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelButtonTapped))
    
    let resetButtonItem = UIBarButtonItem(
      title: "Reset",
      style: .done,
      target: self,
      action: #selector(resetButtonTapped))
    
    self.navigationItem.leftBarButtonItem = cancelButtonItem
    self.navigationItem.rightBarButtonItem = resetButtonItem
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setNavigationBarItem()
    view.addSubview(scrollView)
    setScrollView()
  }
  
  func setScrollView() {
    
    var paddingBottom = view.frame.height/12

    if view.frame.height > 750 {
      paddingBottom = view.frame.height/12.5
    } else if view.frame.height > 800 {
      paddingBottom = view.frame.height/13
    } else if view.frame.height > 850 {
      paddingBottom = view.frame.height/13.5
    }
    
    scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: paddingBottom, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    scrollView.addSubview(priceSliderCell)
    priceSliderCell.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, width: view.frame.width, height: 200)
    
    setupPriceSliderCell()
  }
  
  @objc func cancelButtonTapped() {
    print("cancel")
    
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func resetButtonTapped() {
    
    print("reset")
  }
  
  func setupPriceSliderCell() {
    priceSliderCell.addSubview(minimumLabel)
    priceSliderCell.addSubview(maximumLabel)
    
    minimumLabel.anchor(top: priceSliderCell.topAnchor, left: priceSliderCell.leftAnchor, paddingTop: 20, paddingLeft: 10, width: view.frame.width/2.601, height: 20)
    
    maximumLabel.anchor(top: priceSliderCell.topAnchor, right: priceSliderCell.rightAnchor, paddingTop: 20, paddingRight: 10, width: view.frame.width/2.601, height: 20)
  }
  
  
  

}
