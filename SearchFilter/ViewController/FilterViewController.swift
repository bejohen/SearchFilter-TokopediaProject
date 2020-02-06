//
//  FilterViewController.swift
//  SearchFilter
//
//  Created by Johanes Steven on 06/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
  
  @IBOutlet weak var navigationBar: UINavigationBar!

  override func viewDidLoad() {
    
    super.viewDidLoad()
    setNavigationBarItem()
  }
  
  func setNavigationBarItem() {
    
    let navItem = UINavigationItem(title: "Filter")
    let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(cancelTapped))
    navItem.leftBarButtonItem = cancelItem
    navigationBar.setItems([navItem], animated: false)
  }
  
  @objc func cancelTapped() {
    
    self.dismiss(animated: true, completion: nil)
  }

}
