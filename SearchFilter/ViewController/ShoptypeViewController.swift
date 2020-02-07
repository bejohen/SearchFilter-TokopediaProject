//
//  ShoptypeViewController.swift
//  SearchFilter
//
//  Created by Johanes Steven on 07/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

protocol ShoptypeViewControllerDelegate: class {
  func shopTypeStatus(fshop: Bool?, official: Bool?)
}

class ShoptypeViewController: UIViewController {
  
  var fshop: Bool?
  var official: Bool?
  
  weak var delegate: ShoptypeViewControllerDelegate?
  
  var statusType: [Bool] = []
  
  lazy var tableView: UITableView! = UITableView(frame: view.bounds, style: .grouped)
  
  let shopType = ["Gold Merchant", "Official Store"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let resetButtonItem = UIBarButtonItem(
      title: "Reset",
      style: .done,
      target: self,
      action: #selector(resetButtonTapped))
    
    self.navigationItem.rightBarButtonItem = resetButtonItem
    
    view.addSubview(tableView)

    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.allowsMultipleSelection = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShopTypeCell")
    print("fshop: \(fshop ?? true)")
    
    statusType.append(fshop!)
    statusType.append(official!)
  }
  
  @objc func resetButtonTapped() {
    
    statusType[0] = true
    statusType[1] = true
    
    for x in 0..<statusType.count {
      let cell = tableView.cellForRow(at: [0,x])
      cell?.accessoryType = .checkmark
    }
    
    delegate?.shopTypeStatus(fshop: statusType[0], official: statusType[1])
  }

}

extension ShoptypeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTypeCell", for: indexPath)
    cell.textLabel?.text = shopType[indexPath.item]
    if statusType[indexPath.item] {
      cell.accessoryType = .checkmark
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let selectedCell = tableView.cellForRow(at: indexPath)
    print("indexpat: \(indexPath)")
    if statusType[indexPath.item] {
      statusType[indexPath.item] = false
      selectedCell?.accessoryType = .none
    } else {
      statusType[indexPath.item] = true
      selectedCell?.accessoryType = .checkmark
    }
    selectedCell?.isSelected = false
    delegate?.shopTypeStatus(fshop: statusType[0], official: statusType[1])
  }
}
