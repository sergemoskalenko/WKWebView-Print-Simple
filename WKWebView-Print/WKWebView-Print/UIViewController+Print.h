//
//  UIViewController+Print.h
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UIViewController(Print)
- (void)printTitle:(NSString *)title webView:(WKWebView *)webView;
@end
