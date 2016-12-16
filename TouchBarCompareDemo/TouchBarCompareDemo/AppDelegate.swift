//
//  AppDelegate.swift
//  TouchBarCompareDemo
//
//  Created by Yu Haoran on 2016/12/16.
//  Copyright © 2016年 Fred Yu. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var compareWindowController : CompareWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let compareWindowController = CompareWindowController()
        compareWindowController.showWindow(self)
        self.compareWindowController = compareWindowController
        
    }
}

