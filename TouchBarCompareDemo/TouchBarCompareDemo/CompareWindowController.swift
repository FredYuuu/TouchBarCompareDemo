//
//  CompareWindowController.swift
//  TouchBarCompareDemo
//
//  Created by Yu Haoran on 2016/12/16.
//  Copyright © 2016年 Fred Yu. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    static let touchBar = NSTouchBarCustomizationIdentifier("Fred.touchBar")
}

fileprivate extension NSTouchBarItemIdentifier {
    static let smaller = NSTouchBarItemIdentifier("Fred.smaller")
    static let equal = NSTouchBarItemIdentifier("Fred.equal")
    static let bigger = NSTouchBarItemIdentifier("Fred.bigger")
}

class CompareWindowController: NSWindowController {

    @IBOutlet weak var numberA: NSTextField!
    @IBOutlet weak var numberB: NSTextField!
    @IBOutlet weak var resultLabel: NSTextField!
    
    override var windowNibName: String? {
        return "CompareWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        reset()
        
    }
    
    // MARK: - Button Action
    @IBAction func random(_ sender: NSButton) {
        reset()
    }
    
    
    // MARK: - NSTouchBar
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.smaller, .equal, .bigger]
//        touchBar.customizationAllowedItemIdentifiers = [.smaller, .equal, .bigger]
        
        return touchBar
    }
    
    // MARK: - Private Method
    func compare(symbol : NSButton) {
        
        let number1 = numberA.intValue
        let number2 = numberB.intValue
        var result: Bool
        
        switch symbol.title {
        case "<":
            result = (number1 < number2)
        case "=":
            result = (number1 == number2)
        case ">":
            result = (number1 > number2)
        default:
            result = false
        }
        
        resultLabel.stringValue = (result == true) ? "correct!" : "wrong!"
        resultLabel.textColor = (result == true) ? NSColor.green : NSColor.red
        resultLabel.font = NSFont.systemFont(ofSize: 25)
        
    }
    
    func reset() {
        numberA.intValue = Int32(arc4random_uniform(10))
        numberA.textColor = self.randomColor()
        
        numberB.intValue = Int32(arc4random_uniform(10))
        numberB.textColor = self.randomColor()
        resultLabel.stringValue = "Compare number1 with number2, Please"
        resultLabel.textColor = NSColor.black
        resultLabel.font = NSFont.systemFont(ofSize: 18)
    }
    
    func randomColor() -> NSColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let color = NSColor.init(red: red, green: green, blue: blue, alpha: 1)
        
        return color
    }
}

extension CompareWindowController: NSTouchBarDelegate {
    
    // MARK: - NSTouchBarDelegate
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        let touchBarItem = NSCustomTouchBarItem(identifier : identifier)
        
        var title: String?
        switch identifier {
        case NSTouchBarItemIdentifier.smaller:
            title = "<"
        case NSTouchBarItemIdentifier.equal:
            title = "="
        case NSTouchBarItemIdentifier.bigger:
            title = ">"
        default:
            title = ""
        }
        
        let touchBarButton = NSButton(title: title!, target: self, action: #selector(compare(symbol:)))
        touchBarItem.view = touchBarButton
        
        return touchBarItem
    }
}
