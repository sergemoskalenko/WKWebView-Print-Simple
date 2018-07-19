//
//  SecondViewController.swift
//  WKWebView-Print-Swift
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, UITextFieldDelegate, WKScriptMessageHandler {
    @IBOutlet private weak var urlTextView: UITextField!
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let configuration = WKWebViewConfiguration()
        let script = WKUserScript(source: "window.print = function() { window.webkit.messageHandlers.print.postMessage('print') }", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(script)
        configuration.userContentController.add(self, name: "print")

        let webViewNew = WKWebView(frame: webView.frame, configuration: configuration)
        webViewNew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webViewNew)
        NSLayoutConstraint.copyConstraints(from: webView, to: webViewNew)
        webView.removeFromSuperview()
        webView = webViewNew
        urlTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (urlTextView.text == "") {
            urlTextView.text = "http://picree.com/ex/print/"
            editingDidEndTextView(urlTextView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // Dismiss the keyboard.
        // Execute any additional code
        let urlText = textField.text
        if !(urlText == "") {
            if !(urlText?.hasPrefix("http://") ?? false) && !(urlText?.hasPrefix("https://") ?? false) {
                textField.text = "http://\(urlText ?? "")"
            }
            editingDidEndTextView(textField)
        }
        return true
    }
    
    @IBAction func editingDidEndTextView(_ sender: UITextField) {
        var request: URLRequest? = nil
        if let aText = URL(string: urlTextView.text ?? "") {
            request = URLRequest(url: aText)
        }
        if let aRequest = request {
            webView.load(aRequest)
        }
    }
    
    // MARK: - Print
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        printWebView()
    }
    
    func printWebView() {
        self.printTitle(urlTextView.text, webView: webView)
    }
}
