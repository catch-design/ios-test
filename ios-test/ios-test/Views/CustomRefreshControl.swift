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

    private weak var refreshControl: UIRefreshControl?
    private let endRefreshScale: CGFloat = 0.3
    private let timeInterval: TimeInterval = 0.3

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Init with coder not implemented")
    }

    // Initialise with a standard refresh control.
    convenience init(refreshControl: UIRefreshControl) {
        self.init(frame: refreshControl.bounds)
        refreshControl.addSubview(self)
        imageView.isHidden = true
        imageView.alpha = 0.0
        self.refreshControl = refreshControl
    }

    // MARK: Private

    private func commonInit() {
        Bundle.main.loadNibNamed("CustomRefreshControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - Refresh start / stop

    func beginRefreshing() {
        refreshControl?.beginRefreshing()
        imageView.isHidden = false
        imageView.transform = CGAffineTransform(scaleX: endRefreshScale, y: endRefreshScale)
        imageView.rotate()
        UIView.animate(withDuration: timeInterval, animations: {
            self.imageView.alpha = 1.0
            self.imageView.transform = CGAffineTransform.identity
        },
        completion: {_ in
            self.imageView.isHidden = false
            self.isRefreshing = true
        })
    }

    func endRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard let strongSelf = self else {
                return
            }
            UIView.animate(withDuration: strongSelf.timeInterval, animations: {
                strongSelf.imageView.alpha = 0.0
                strongSelf.imageView.transform = CGAffineTransform(scaleX: strongSelf.endRefreshScale, y: strongSelf.endRefreshScale)
            },
            completion: {_ in
                strongSelf.imageView.stopAnimating()
                strongSelf.imageView.isHidden = true
                strongSelf.isRefreshing = false
                strongSelf.refreshControl?.endRefreshing()
            })
        }
    }

}
