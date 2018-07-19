
//
//  UIViewController+Print.swift
//  WKWebView-Print-Swift
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

import UIKit
import WebKit

extension UIViewController {
    func printTitle(_ title: String?, webView: WKWebView?) {
        let controller = UIPrintInteractionController.shared
        let printCompletionHandler: UIPrintInteractionCompletionHandler = { (controller, success, error) -> Void in
            if success {
                print("Print: OK")
            } else {
                 print("Print: ERROR")
            }
        }

        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        printInfo.jobName = title ?? ""
        printInfo.duplex = .longEdge
        controller.printInfo = printInfo
        controller.showsPageRange = true
        let viewFormatter: UIViewPrintFormatter? = webView?.viewPrintFormatter()
        viewFormatter?.startPage = 0
        controller.printFormatter = viewFormatter
        if UI_USER_INTERFACE_IDIOM() == .pad {
            controller.present(from: self.view.bounds, in: self.view, animated: true, completionHandler: printCompletionHandler)
        } else {
            controller.present(animated: true, completionHandler: printCompletionHandler)
        }
    }
}
