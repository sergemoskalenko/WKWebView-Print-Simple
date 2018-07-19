//
//  FirstViewController.swift
//  WKWebView-Print-Swift
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//
//

import UIKit
import WebKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var urlTextView: UITextField!
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var printButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urlTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (urlTextView.text == "") {
            urlTextView.text = "http://me.com"
            editingDidEndTextView(urlTextView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    @IBAction func printButtonAction(_ sender: UIButton) {
        self.printTitle(urlTextView.text, webView: webView)
    }
}
