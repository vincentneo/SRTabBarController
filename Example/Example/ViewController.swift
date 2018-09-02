//
//  ViewController.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Updated by Vincent Neo on 02/09/2018.
//
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

class ViewController: SRTabBarController {

    override func viewDidLoad() {
        tabBarImagePosition = .imageLeft
        tabBarFont = NSFont.systemFont(ofSize: 12, weight: .black)
        super.viewDidLoad()
        
        tabBarLocation = .Top
        tabBar?.translucent = true
//        tabBar?.backgroundColor = .darkGray
//        tabBar?.material = .ultraDark
        tabBar?.material = .titlebar
        tabBar?.blendingMode = .withinWindow
    }

}

