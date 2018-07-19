//
//  NSLayoutConstraint+Copy.h
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint(Copy)
+ (void)copyConstraintsFromView:(UIView *)oldView toView:(UIView *)newView;
@end
