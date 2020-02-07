//
//  FilterViewController.swift
//  SearchFilter
//
//  Created by Johanes Steven on 06/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialChips

protocol FilterViewControllerDelegate: class {
  func applyFilter(filterModel: FilterModel?, resetData: Bool)
}

class FilterViewController: UIViewController {
  
  weak var delegate: FilterViewControllerDelegate?
  
  var filterModel: FilterModel?
  
  var query: String!
  var minPrice: Int?
  var maxPrice: Int?

  let scrollView: UIScrollView = {
    let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.backgroundColor = #colorLiteral(red: 0.9491834044, green: 0.9487034678, blue: 0.9704388976, alpha: 1)
    return view
  }()
  
  let priceSliderCell: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.backgroundColor = .white
    return view
  }()
  
  let shopTypeCell: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.backgroundColor = .white
    return view
  }()
  
  let minimumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.text = "Minimum price"
    return label
  }()
  
  let maximumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .right
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.text = "Maximum price"
    return label
  }()
  
  let slider: RangeSeekSlider = {
    let slider = RangeSeekSlider(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    slider.labelsFixed = true
    slider.minValue = 0
    slider.maxValue = 10000000
    slider.handleColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    slider.minLabelColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    slider.maxLabelColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    slider.handleDiameter = 20.0
    slider.selectedHandleDiameterMultiplier = 1.3
    slider.lineHeight = 5.0
    slider.numberFormatter.numberStyle = .currency
    slider.numberFormatter.positivePrefix = "Rp "
    slider.minLabelFont = UIFont.systemFont(ofSize: 14)
    slider.maxLabelFont = UIFont.systemFont(ofSize: 14)
    slider.colorBetweenHandles = #colorLiteral(red: 0.2615385652, green: 0.707508862, blue: 0.2872550189, alpha: 1)
    slider.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    slider.enableStep = true
    slider.step = 1000.0
    slider.backgroundColor = .clear
    return slider
  }()
  
  let wholesaleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.text = "Whole Sale"
    return label
  }()
  
  var wholesaleSwitch: UISwitch = {
    let button = UISwitch()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(wholesaleSwitchTapped), for: .touchUpInside)
    button.isEnabled = true
    return button
  }()
  
  let shopTypeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.text = "Shop Type"
    return label
  }()
  
  let shopTypeButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    button.backgroundColor = .clear
    button.setTitle("❯", for: .normal)
    button.contentHorizontalAlignment = .right
    button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
//    button.layer.cornerRadius = 10
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    button.addTarget(self, action: #selector(shopTypeButtonTapped), for: .touchUpInside)
    return button
  }()
  
  let mdGoldMerchantButton: MDCChipView = {
    let chipView = MDCChipView()
    chipView.titleLabel.text = "Gold Merchant"
    chipView.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
    chipView.setBackgroundColor(#colorLiteral(red: 0.2615385652, green: 0.707508862, blue: 0.2872550189, alpha: 1), for: .selected)
    chipView.sizeToFit()
    chipView.addTarget(self, action: #selector(mdGoldMerchantTapped), for: .touchUpInside)
    return chipView
  }()
  
  let mdOfficialButton: MDCChipView = {
    let chipView = MDCChipView()
    chipView.titleLabel.text = "Official"
    chipView.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
    chipView.setBackgroundColor(#colorLiteral(red: 0.2615385652, green: 0.707508862, blue: 0.2872550189, alpha: 1), for: .selected)
    chipView.sizeToFit()
    chipView.addTarget(self, action: #selector(mdOfficialTapped), for: .touchUpInside)
    return chipView
  }()
  
  let applyButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    button.backgroundColor = #colorLiteral(red: 0.2615385652, green: 0.707508862, blue: 0.2872550189, alpha: 1)
    button.setTitle("Apply", for: .normal)
    button.layer.cornerRadius = 10
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    return button
  }()
  
  func setNavigationBarItem() {

    let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelButtonTapped))
    
    let resetButtonItem = UIBarButtonItem(
      title: "Reset",
      style: .done,
      target: self,
      action: #selector(resetButtonTapped))
    
    filterModel = FilterModel(q: query,pmin: 10000, pmax: 8000000, wholesale: true, official: true, fshop: true)
    
    self.navigationItem.leftBarButtonItem = cancelButtonItem
    self.navigationItem.rightBarButtonItem = resetButtonItem
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    setNavigationBarItem()
    view.addSubview(scrollView)
    view.addSubview(applyButton)
    setScrollView()
    setupButtonView()
    initialState()
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
    applyButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: paddingBottom, paddingRight: 12, width: view.frame.width, height: view.frame.height/15)
  }
  
  func setScrollView() {
    
//    var paddingBottom = view.frame.height/10
//
//    if view.frame.height > 750 {
//      paddingBottom = view.frame.height/10.5
//    } else if view.frame.height > 800 {
//      paddingBottom = view.frame.height/11
//    } else if view.frame.height > 850 {
//      paddingBottom = view.frame.height/11.5
//    }
    
    scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    scrollView.addSubview(priceSliderCell)
    priceSliderCell.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, width: view.frame.width, height: 170)
    
    setupPriceSliderCell()
    
    scrollView.addSubview(shopTypeCell)
    
    shopTypeCell.anchor(top: priceSliderCell.bottomAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingRight: 5, width: view.frame.width, height: 100)
    
    setupShopTypeCell()
  }

  
  func initialState() {
    filterModel?.pmin = 10000
    filterModel?.pmax = 8000000
    filterModel?.wholesale = true
    
    filterModel?.official = true
    filterModel?.fshop = true
    
    slider.selectedMinValue = CGFloat(Float(filterModel!.pmin!))

    slider.selectedMaxValue = CGFloat(Float(filterModel!.pmax!))
    slider.updateHandlePositions()
    wholesaleSwitch.isOn = filterModel!.wholesale!
    mdGoldMerchantButton.isSelected = true
    mdOfficialButton.isSelected = true
  }
  
  func setupPriceSliderCell() {
    
    priceSliderCell.addSubview(minimumLabel)
    priceSliderCell.addSubview(maximumLabel)
   
    priceSliderCell.addSubview(slider)
    slider.delegate = self
    
    minimumLabel.anchor(top: priceSliderCell.topAnchor, left: priceSliderCell.leftAnchor, paddingTop: 20, paddingLeft: 12, width: view.frame.width/2.601, height: 15)
    
    maximumLabel.anchor(top: priceSliderCell.topAnchor, right: priceSliderCell.rightAnchor, paddingTop: 20, paddingRight: 12, width: view.frame.width/2.601, height: 15)
    
    slider.selectedMinValue = CGFloat(Float(filterModel!.pmin!))
    slider.selectedMaxValue = CGFloat(Float(filterModel!.pmax!))
    
    slider.anchor(top: minimumLabel.bottomAnchor, left: priceSliderCell.leftAnchor, right: priceSliderCell.rightAnchor, paddingTop: 7, paddingLeft: 12, paddingRight: 12, width: view.frame.width, height: 80)
    
    priceSliderCell.addSubview(wholesaleLabel)
    priceSliderCell.addSubview(wholesaleSwitch)
    
    wholesaleSwitch.isOn = filterModel!.wholesale!
    
    
    wholesaleLabel.anchor(left: priceSliderCell.leftAnchor, bottom: priceSliderCell.bottomAnchor, right: priceSliderCell.rightAnchor, paddingLeft: 12, paddingBottom: 20, paddingRight: 12, width: view.frame.width/2.601, height: 12)
    wholesaleSwitch.anchor(bottom: priceSliderCell.bottomAnchor, right: priceSliderCell.rightAnchor, paddingTop: nil, paddingLeft: nil, paddingBottom: 10, paddingRight: 20, width: nil, height: nil)
  }
  
  func setupShopTypeCell() {
    
    shopTypeCell.addSubview(shopTypeLabel)
    shopTypeCell.addSubview(shopTypeButton)
    
    shopTypeCell.addSubview(mdGoldMerchantButton)
    shopTypeCell.addSubview(mdOfficialButton)
    
    shopTypeLabel.anchor(top: shopTypeCell.topAnchor, left: shopTypeCell.leftAnchor, paddingTop: 20, paddingLeft: 12, width: view.frame.width/2.601, height: 20)
    shopTypeButton.anchor(top: shopTypeCell.topAnchor, left: shopTypeCell.leftAnchor, right: shopTypeCell.rightAnchor, paddingTop: 12, paddingLeft: 10, paddingRight: 10, width: view.frame.width, height: 40)
    
    mdGoldMerchantButton.anchor(left: shopTypeCell.leftAnchor, bottom: shopTypeCell.bottomAnchor, paddingLeft: 10, paddingBottom: 12, height: 30)
    mdOfficialButton.anchor(left: mdGoldMerchantButton.rightAnchor, bottom: shopTypeCell.bottomAnchor, paddingLeft: 10, paddingBottom: 12, height: 30)
    
  }
  
  @objc func applyButtonTapped() {
    
    delegate?.applyFilter(filterModel: filterModel, resetData: true)
    self.dismiss(animated: true, completion: nil)
    
  }
  
  @objc func wholesaleSwitchTapped() {
    
    if wholesaleSwitch.isOn {
      filterModel?.wholesale = true
    } else {
      filterModel?.wholesale = false
    }
  }
  
  @objc func mdGoldMerchantTapped() {
    if mdGoldMerchantButton.isSelected {
      filterModel?.fshop = false
      mdGoldMerchantButton.isSelected = false
    } else {
      filterModel?.fshop = true
      mdGoldMerchantButton.isSelected = true
    }
  }
  
  @objc func mdOfficialTapped() {
    if mdOfficialButton.isSelected {
      filterModel?.official = false
      mdOfficialButton.isSelected = false
    } else {
      filterModel?.official = true
      mdOfficialButton.isSelected = true
    }
  }
  
  @objc func shopTypeButtonTapped() {
    print("shopType")
    
    let shopTypeVC = ShoptypeViewController()
    shopTypeVC.fshop = filterModel?.fshop
    shopTypeVC.official = filterModel?.official
    shopTypeVC.delegate = self
    navigationController?.pushViewController(shopTypeVC, animated: true)
  }
  
  @objc func resetButtonTapped() {
    
    initialState()
    print("reset")
  }
  
  
  @objc func cancelButtonTapped() {
    print("cancel")
    
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension FilterViewController: RangeSeekSliderDelegate {

  func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
    
    filterModel?.pmin = Int(minValue)
    filterModel?.pmax = Int(maxValue)
  }
}

extension FilterViewController: ShoptypeViewControllerDelegate {
  
  func shopTypeStatus(fshop: Bool?, official: Bool?) {
    filterModel?.fshop = fshop
    mdGoldMerchantButton.isSelected = filterModel!.fshop!
    filterModel?.official = official
    mdOfficialButton.isSelected = filterModel!.official!
  }
}
