//
//  CustomFooterView.swift
//  SearchFilter
//
//  Created by Johanes Steven on 06/02/20.
//  Copyright © 2020 bejohen. All rights reserved.
//

import UIKit

class CustomFooterView : UICollectionReusableView {

  
  @IBOutlet weak var refreshIndicator: UIActivityIndicatorView!
  
  var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
        self.refreshIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
        self.refreshIndicator?.stopAnimating()
        self.refreshIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimate() {
        self.isAnimatingFinal = true
        self.refreshIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        self.isAnimatingFinal = false
        self.refreshIndicator?.stopAnimating()
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshIndicator?.transform = CGAffineTransform.identity
        }
    }
}
