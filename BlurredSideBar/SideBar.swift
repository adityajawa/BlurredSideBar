//
//  SideBar.swift
//  BlurredSideBar
//
//  Created by Mavericks on 25/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate{
    func sideBarDidSelectButtonAtIndex(index:Int)
    optional func sideBarWillOpen()
    optional func sideBarWillClose()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate {

    let barWidth: CGFloat = 150.0
    let sideBarTableViewTopInset: CGFloat = 75.0
    let sideBarContainerView: UIView = UIView()
    let sideBarTableViewController: SideBarTableViewController = SideBarTableViewController()
    var originView: UIView!
    
    var animator: UIDynamicAnimator = UIDynamicAnimator()
    var delegate: SideBarDelegate?
    var isSideBarOpen: Bool = false
    
    override init() {
        super.init()
    }
    
    init(sourceView: UIView, menuItems: Array<String>) {
        super.init()
        originView = sourceView
        sideBarTableViewController.menuData = menuItems
        
        setupSideBar()
        
     
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        originView.addGestureRecognizer(swipeRight)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(swipeLeft)
        
    }
    
    func setupSideBar(){
        sideBarContainerView.frame = CGRect(x: -barWidth - 1, y: originView.frame.origin.y, width: barWidth, height: originView.frame.size.height)
        sideBarContainerView.clipsToBounds = false
        sideBarContainerView.backgroundColor = UIColor.clearColor()
        
        originView.addSubview(sideBarContainerView)
        
        let blur: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blur.frame = sideBarContainerView.bounds
        
        sideBarContainerView.addSubview(blur)
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsets(top: sideBarTableViewTopInset, left: 0, bottom: 0, right: 0)
        
        sideBarTableViewController.tableView.reloadData()
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left {
            showSideBar(false)
            delegate?.sideBarWillClose?()
        }else {
            showSideBar(true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(shouldOpen:Bool) {
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX: CGFloat = (isSideBarOpen) ? 0.5 : -0.5
        let magnitude: CGFloat = (isSideBarOpen) ? 20 : -20
        let boundayX: CGFloat = (isSideBarOpen) ? barWidth : -barWidth - 1
        
        let gravityBehavior: UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior: UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPoint(x: boundayX, y: 20), toPoint: CGPoint(x: boundayX, y: originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior: UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
        
    }
    
    func didSelectRow(indexPath: NSIndexPath) {
        delegate?.sideBarDidSelectButtonAtIndex(indexPath.row)
    }
    
}
