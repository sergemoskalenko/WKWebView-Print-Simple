
//
//  NSLayoutConstraint+Copy.m
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    class func copy(constraint: NSLayoutConstraint?, for oldView: UIView?, newView: UIView?)  -> NSLayoutConstraint?  {
        var anItem = constraint?.firstItem
        if let testView:UIView = anItem as! UIView? {
            if testView === oldView {
                anItem = newView
            }
        }
        var anItem2 = constraint?.secondItem
        if let testView:UIView = anItem2 as! UIView? {
            if testView === oldView {
                anItem2 = newView
            }
        }
        let anAttribute = constraint?.firstAttribute
        let aRelation = constraint?.relation
        let anAttribute1 = constraint?.secondAttribute
        let newConstraint: NSLayoutConstraint?  = NSLayoutConstraint(item: anItem as Any, attribute: anAttribute!, relatedBy: aRelation!, toItem: anItem2, attribute: anAttribute1!, multiplier: constraint?.multiplier ?? 0.0, constant: constraint?.constant ?? 0.0)

        return newConstraint
    }
    
    
    class func constraintsWitView(_ oldView: UIView?, newView: UIView?) -> [NSLayoutConstraint]? {
        var newConstraints: [AnyHashable] = []
        for constraint: NSLayoutConstraint? in oldView?.constraints ?? [NSLayoutConstraint?]() {
            
            let anItem = constraint?.firstItem as AnyObject?
            if anItem === oldView as AnyObject {
            } else {
                let anItem2 = constraint?.secondItem  as AnyObject?
                if anItem2 === oldView as AnyObject  {
                } else {
                    continue
                }
            }

            if let newConstraint: NSLayoutConstraint = self.copy(constraint: constraint, for: oldView, newView: newView) {
                newConstraints.append(newConstraint)
            }
        }
        return newConstraints as? [NSLayoutConstraint]
    }
    
    class func constraintsWitSuperView(_ oldView: UIView?, newView: UIView?) -> [NSLayoutConstraint]? {
        var newConstraints: [AnyHashable] = []
        for constraint: NSLayoutConstraint? in (oldView?.superview)?.constraints ?? [NSLayoutConstraint?]() {
            
            let anItem = constraint?.firstItem as AnyObject?
            if anItem === oldView as AnyObject {
            } else {
                let anItem2 = constraint?.secondItem  as AnyObject?
                if anItem2 === oldView as AnyObject  {
                } else {
                    continue
                }
            }
            
            if let newConstraint: NSLayoutConstraint = self.copy(constraint: constraint, for: oldView, newView: newView) {
                newConstraints.append(newConstraint)
            }
        }
        return newConstraints as? [NSLayoutConstraint]
    }
    
    class func copyConstraints(from oldView: UIView?, to newView: UIView?) {
        if let aView = self.constraintsWitView(oldView, newView: newView) {
            newView?.addConstraints(aView)
        }
        if let aView = self.constraintsWitSuperView(oldView, newView: newView) {
            newView?.superview?.addConstraints(aView)
        }
    }
}
