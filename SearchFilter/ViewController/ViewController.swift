//
//  ViewController.swift
//  SearchFilter
//
//  Created by Johanes Steven on 04/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
  
  public var filterModel: FilterModel?
  public var resetModel = false
  
  private var apiService = ApiService()
  private var cancellable: AnyCancellable?
  private var productFiltered: [ProductModel] = [] {
    didSet {
      collectionView.reloadData()
      print("total repos: \(productFiltered.count)")
    }
  }
  
  let filterVC = FilterViewController()
  
  let cellID = "filterProductCell"
  let footerViewReuseIdentifier = "RefreshFooterView"
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
    layout.scrollDirection = .vertical
    collection.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.isScrollEnabled = true
    return collection
  }()
  
  var footerView:CustomFooterView?
  var isLoading:Bool = false
  var loadedProduct: Int = 10
  
  let filterButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    button.backgroundColor = #colorLiteral(red: 0.2615385652, green: 0.707508862, blue: 0.2872550189, alpha: 1)
    button.setTitle("Filter", for: .normal)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    return button
  }()
  
  @objc func buttonAction(sender: UIButton!) {
    
    filterVC.query = filterModel!.q!
    let navVC = UINavigationController(rootViewController: filterVC)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true, completion: nil)
    
//    performSegue(withIdentifier: "toFilterVC", sender: self)

    print("Button tapped")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    filterVC.delegate = self

    collectionView.register(FilterProductCell.self, forCellWithReuseIdentifier: cellID)
    
    collectionView.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
    
    filterModel = FilterModel(q: "samsung")
    
    view.addSubview(collectionView)
    view.addSubview(filterButton)
    setupCollectionView()
    setupButtonView()
    fetchProduct(start: 0)
  }
  
  func setupCollectionView() {

    var paddingBottom = view.frame.height/10

    if view.frame.height > 750 {
      paddingBottom = view.frame.height/10.5
    } else if view.frame.height > 800 {
      paddingBottom = view.frame.height/11
    } else if view.frame.height > 850 {
      paddingBottom = view.frame.height/11.5
    }
    
    collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: paddingBottom, paddingRight: 0, width: view.frame.width, height: view.frame.height)
  }
  
  func setupButtonView() {
    
    var paddingBottom: CGFloat = 10
    if view.frame.height > 750 {
      paddingBottom = 14
    } else if view.frame.height > 800 {
      paddingBottom = 18
    } else if view.frame.height > 850 {
      paddingBottom = 20
    }
    filterButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: paddingBottom, paddingRight: 12, width: view.frame.width, height: view.frame.height/15)
  }
  
  private func fetchProduct(start: Int) {
    
    if let filterModel = filterModel {
      self.cancellable = self.apiService.scrollProduct(filterModel: filterModel, start: start)
        .sink(receiveCompletion: { _ in }, receiveValue: { (data) in
          for var dat in data {
            self.productFiltered.append(dat)
          }
        })
    }
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return productFiltered.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FilterProductCell
    
    cell.setProductDataCell(product: productFiltered[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width)/2.061
    
    var height = view.frame.height/2.3
    
    if view.frame.height > 750 {
      height = view.frame.height/2.8
    } else if view.frame.height > 800 {
      height = view.frame.height/3.3
    } else if view.frame.height > 850 {
      height = view.frame.height/3.8
    }
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 1
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let product = productFiltered[indexPath.row]
    print("impression - \(String(describing: product.id!)), \(String(describing: product.name!))")
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
      if isLoading {
          return CGSize.zero
      }
    return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height/40)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionFooter {
          let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath) as! CustomFooterView
          self.footerView = aFooterView
          self.footerView?.backgroundColor = UIColor.clear
          return aFooterView
      } else {
          let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath)
          return headerView
      }
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    if elementKind == UICollectionView.elementKindSectionFooter {
          self.footerView?.prepareInitialAnimation()
      }
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
    if elementKind == UICollectionView.elementKindSectionFooter {
          self.footerView?.stopAnimate()
      }
  }
  
  //compute the scroll value and play witht the threshold to get desired effect
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let threshold = 100.0
    let contentOffset = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let diffHeight = contentHeight - contentOffset
    let frameHeight = scrollView.bounds.size.height
    var triggerThreshold = Float((diffHeight - frameHeight))/Float(threshold)
    triggerThreshold = min(triggerThreshold, 0.0)
    let pullRatio = min(abs(triggerThreshold),1.0)
    
    self.footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
    if pullRatio >= 1 {
      self.footerView?.animateFinal()
    }
//    print("pullRation:\(pullRatio)")
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    let contentOffset = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let diffHeight = contentHeight - contentOffset
    let frameHeight = scrollView.bounds.size.height
    let pullHeight  = abs(diffHeight - frameHeight)
    print("pullHeight:\(pullHeight)")
    
    if pullHeight >= 0.0 {
      if (self.footerView?.isAnimatingFinal)! {
        print("load more trigger")
        self.isLoading = true
        self.footerView?.startAnimate()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer:Timer) in
          print("loaded : \(self.loadedProduct)")
          self.fetchProduct(start: self.loadedProduct)
          self.loadedProduct+=10
          self.isLoading = false
        })
      }
    }
  }
}

extension ViewController: FilterViewControllerDelegate {
  
  func applyFilter(filterModel: FilterModel?, resetData: Bool) {
    if resetData {
      self.productFiltered.removeAll()
      self.loadedProduct = 10
    }
    self.filterModel = filterModel
    fetchProduct(start: 0)
  }
}
