//
//  ScrollViewController.swift
//  ScrollingNavbarDemo
//
//  Created by Andrea Mazzini on 18/08/15.
//  Copyright (c) 2015 Fancy Pixel. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class ScrollViewController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var extensionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ScrollView"
        
        
//        let v = UIView(frame: CGRectMake(0, (self.navigationController?.navigationBar.frame.size.height)!, self.view.frame.size.width, 30))
//        v.backgroundColor = UIColor.redColor()
//        self.navigationController?.navigationBar.addSubview(v)

//        navigationItem.prompt = "Prompt"

        navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.59, blue:0.87, alpha:1)

        scrollView.backgroundColor = UIColor(red:0.13, green:0.5, blue:0.73, alpha:1)

        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 0, height: 0))
        if let font = UIFont(name: "STHeitiSC-Light", size: 20) {
            label.font = font
        }
        scrollView.addSubview(label)

        // Fake some content
        label.text = lyrics.first
        label.numberOfLines = 0
        label.textColor = .whiteColor()
        label.sizeToFit()

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: label.frame.size.height)
        scrollView.delegate = self
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.extensionTopConstraint = self.topConstraint
            navigationController.extensionTopExpanded = 0
            navigationController.extensionHeight = 30
            navigationController.extensionView = self.extensionView
        }
        
//        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
//        gestureRecognizer.maximumNumberOfTouches = 1
//        gestureRecognizer.delegate = self
//        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    var lastContentOffset: CGFloat = 0
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state != .Failed {
            if let superview = scrollView.superview {
                let translation = gesture.translationInView(superview)
                let delta = lastContentOffset - translation.y
                lastContentOffset = translation.y
                print("1: \(delta)")
//                if shouldScrollWithDelta(delta) {
//                    scrollWithDelta(delta)
//                }
                var constant = self.topConstraint.constant - delta
                if constant < -44-30 {
                   constant = -44-30
                }
                if constant > 0 {
                    constant = 0
                }
                self.topConstraint.constant = constant
            }
        }
        
        if gesture.state == .Ended || gesture.state == .Cancelled || gesture.state == .Failed {
//            checkForPartialScroll()
            lastContentOffset = 0
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func scrollingNavigationController(controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
        switch state {
        case .Collapsed:
            print("navbar collapsed")
        case .Expanded:
            print("navbar expanded")
        case .Scrolling:
            print("navbar is moving")
        }
    }
    
    func scrollingNavigationController(controller: ScrollingNavigationController, deltaChanged delta: CGFloat) {
//        var offset = delta
//        if offset < 0 { // show
//            if controller.navigationBar.frame.origin.y - (UIApplication.sharedApplication().statusBarFrame.size.height - self.view.convertRect(self.view.bounds, toView: nil).minY) == 0 {
//                offset = 0
//            }
//            else {
//                offset = 30+44 + offset
//                if offset < 0 {
//                    offset = 0
//                }
//            }
//        }
//        else { // hide
//            if offset > 30+44 {
//                offset = 30+44
//            }
//        }
//        self.topConstraint.constant = -offset
    }

    // Enable the navbar scrolling
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(scrollView, delay: 0.0)
            navigationController.scrollingNavbarDelegate = self
        }
    }

    let lyrics = [
    "It's all in motion\nNo stoppin' now\nI've got nothin' to lose\nAnd only one way up\n\nI'm burning bridges\nI destroy the mirage\nOh, visions of collisions\nFuckin 'bon voyage\n\nIt's all smooth sailing\nFrom here on out\n\nI got bruises and hickies\nStitches and scars\nGot my own theme music\nIt plays wherever I are\n\nFear is the hand \nThat pulls your strings\nA useless toy\nPitiful plaything\n\nI'm inflagranti\nIn every way\n\nIt's all smooth sailing\nFrom here on out\nI'm gon' do the damage\nThat needs gettin' done\n\nGod only knows\nWhere love vacations\nIf reason is priceless\nThere's no reason to pay for it\n\nIt's so easy to see\nAnd so hard to find\nMake a mountain of a mole hill\nIf the mole hill is mine\n\nI hypnotize you\nAnd no one can find you\nI blow my load\nOver the status quo\nHere we go\n\nI'm a little bit nonchalant \nBut I dance\nI'm risking it always\nNo second chance\n\nIt's gonna be smooth sailing\nFrom here on out\nI'm gon' do the damage\n'Til the damage is done yeah\n\nGod only knows\nSo mind your behavior\nFollow prescriptions\nOf your lord and savior\n\nEvery temple is gold\nEvery hook is designed\nHell is but the temple\nOf the closed mind\nClosed mind\nClosed mind\nClosed mind\n\nIt's all smooth sailing\nFrom here on out\n\nShut up\n"
    ]
}
