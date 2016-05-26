//
//  IZRefreshControl.swift
//  RefreshControl
//
//  Created by Dmitry Kulakov on 21.10.15.
//  Copyright © 2015 Dmitry Kulakov. All rights reserved.
//

import UIKit

class IZRefreshControl: UIRefreshControl {

    var refreshContainerView: UIView!
    var indicatorImage: UIImageView!
    var isRefreshAnimating = false
    var images : [UIImage]?
    var indicatorSize : CGFloat = 36
    
    /**
    Use init(frame:) instead
    */
    required override init() {
        fatalError("use init(frame:) instead")
    }
    
    /**
    Use init(frame:) instead
    */
    required init(coder aDecoder: NSCoder) {
        fatalError("use init(frame:) instead")
    }
    
    /**
    Initialize the iz refresh control
    */
    required override init(frame: CGRect) {
        self.images = []
        super.init()
        bounds.size.width = frame.size.width
                addImages()
        setupRefreshControl()
    }
    
    func addImages(){
        for i in 1 ..< 22 {
            let imageName = NSString(format: "spinner31-\(i)")
            self.images?.append(UIImage(named : imageName as String)!)
        }
        print(self.images)
    }
    
    func setupRefreshControl(){
        refreshContainerView = UIView(frame: self.bounds)
        //self.backgroundColor = UIColor.redColor()
        refreshContainerView.backgroundColor = UIColor.clearColor()
        self.indicatorImage = UIImageView(frame: CGRectMake(0, 0, indicatorSize, indicatorSize))
        self.indicatorImage.center = refreshContainerView.center
        self.indicatorImage.image = UIImage(named: "spinner31-1")
        self.indicatorImage.alpha = 0.0
        refreshContainerView.tintColor = UIColor.clearColor()
        refreshContainerView.addSubview(self.indicatorImage)
        addSubview(refreshContainerView)
    }
    
    func animateRefreshView(){
        isRefreshAnimating = true
        self.indicatorImage.animationImages = self.images
        self.indicatorImage.animationDuration = 2.0
        self.indicatorImage.startAnimating()
    }
    
    func stopAnimatingRefreshView() {
        self.indicatorImage.stopAnimating()
        self.isRefreshAnimating = false
        
        //print("end")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        //var refreshBounds = self.bounds;
        let pullDistance = max(0.0, -self.frame.origin.y*1.66/100)
        print(pullDistance/100)
//        self.indicatorImage.center = CGPoint(x: CGRectGetMidX(self.refreshContainerView.frame), y: pullDistance / 2-20)
//        //refreshBounds.size.height = pullDistance
//        self.indicatorImage.autoresizingMask = [.FlexibleTopMargin,.FlexibleBottomMargin]
       indicatorImage.alpha = pullDistance
        if (self.refreshing && !self.isRefreshAnimating) {
                self.animateRefreshView()
        }
        
        //self.indicatorImage.frame = indicatorFrame
        if !self.refreshing {
            self.stopAnimatingRefreshView()
        }
     }
}
