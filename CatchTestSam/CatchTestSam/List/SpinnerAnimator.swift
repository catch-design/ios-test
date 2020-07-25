//
//  SpinnerAnimator.swift
//  CatchTestSam
//
//  Created by smoriyasu on 26/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit
import Refreshable

class SpinnerAnimator: UIView, PullToRefreshDelegate
{
    var spinner : UIImageView!
	var header : UIView!
	
	override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleWidth
		self.backgroundColor = .black;
		
		let headerFrame = CGRect(x: 0, y: -1000, width: 2000, height: 1000);
		header = UIView(frame: headerFrame);
		self.header.backgroundColor = UIColor(white: 0.4, alpha: 1.0);
		addSubview(self.header);

		self.spinner = UIImageView(image: UIImage(named: "Spinner"));
        addSubview(spinner)
        spinner.isHidden = true
    }
	
	public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func layoutSubviews() {
		self.spinner.center = self.center;
	}
	
	func pullToRefreshAnimationDidStart(_ view: PullToRefreshView)
	{
		startAnimation();
	}
	
	func pullToRefreshAnimationDidEnd(_ view: PullToRefreshView)
	{
        spinner.isHidden = true
	}
	
	func pullToRefresh(_ view: PullToRefreshView, stateDidChange state: PullToRefreshState)
	{
		
		//self.backgroundColor = .green;
	}
	
	func setColorFromDisplacement(offset: CGFloat, maxOffset: CGFloat)
	{
		let brightness = CGFloat((max(min(offset, maxOffset), 0) / maxOffset) * 0.4);
		self.backgroundColor = UIColor(white: brightness, alpha: 1.0);
	}
	
	func startAnimation()
	{
		self.spinner.isHidden = false;
		self.spinner.alpha = 0.0;
		
		UIView.animate(withDuration: 0.1) {
			self.spinner.alpha = 1.0;
		}
		animateSpinner();
	}
    func animateSpinner()
	{
		UIView.animate(
			withDuration: Double(0.3),
            delay: Double(0.0),
			options: UIView.AnimationOptions.curveLinear,
            animations: {
                // Rotate the spinner by M_PI_2 = PI/2 = 90 degrees
				self.spinner.transform = self.spinner.transform.rotated(by: -.pi/2)
                
            },
            completion: { finished in
				if(!self.spinner.isHidden)
				{
					self.animateSpinner();
				}
            }
        )
    }
}
