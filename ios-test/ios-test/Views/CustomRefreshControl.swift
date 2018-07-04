//
//  CustomRefreshControl.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import UIKit

class CustomRefreshControl: UIView {
    
    @IBOutlet var contentView: CustomRefreshControl!
    @IBOutlet weak var imageView: UIImageView!

    var isRefreshing = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Init with coder not implemented")
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("CustomRefreshControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.isHidden = true
    }

    func beginRefreshing() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = Float.infinity
        imageView.layer.add(rotateAnimation, forKey: nil)
        imageView.isHidden = false
        isRefreshing = true
    }

    func endRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            self?.imageView.layer.removeAllAnimations()
            self?.imageView.isHidden = true
            self?.isRefreshing = false
        }
    }

}
