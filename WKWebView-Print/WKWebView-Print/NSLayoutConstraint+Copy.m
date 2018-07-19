//
//  NSLayoutConstraint+Copy.m
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

#import "NSLayoutConstraint+Copy.h"

@implementation NSLayoutConstraint(Copy)
+(instancetype)constraintWithConstraint:(NSLayoutConstraint *)constraint forView:(UIView *)oldView newView:(UIView *)newView {
    NSLayoutConstraint* newConstraint = [NSLayoutConstraint constraintWithItem:(constraint.firstItem == oldView ? newView : constraint.firstItem) attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:(constraint.secondItem == oldView ? newView : constraint.secondItem) attribute:constraint.secondAttribute multiplier:constraint.multiplier constant:constraint.constant];
    
    return newConstraint;
}

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsWitView:(UIView *)oldView newView:(UIView *)newView {
    NSMutableArray* newConstraints = [@[] mutableCopy];
    
    for (NSLayoutConstraint* constraint in oldView.constraints) {
        if (constraint.firstItem == oldView || constraint.secondItem == oldView) {
            NSLayoutConstraint* newConstraint = [self constraintWithConstraint:constraint forView:oldView newView:newView];
            if (newConstraint)
                [newConstraints addObject:newConstraint];
        }
    }
    
    return [newConstraints copy];
}

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsWitSuperView:(UIView *)oldView newView:(UIView *)newView {
    NSMutableArray* newConstraints = [@[] mutableCopy];
    
    for (NSLayoutConstraint* constraint in (oldView.superview).constraints) {
        if (constraint.firstItem == oldView || constraint.secondItem == oldView) {
            NSLayoutConstraint* newConstraint = [self constraintWithConstraint:constraint forView:oldView newView:newView];
            if (newConstraint)
                [newConstraints addObject:newConstraint];
        }
    }
    
    return [newConstraints copy];
}

+ (void)copyConstraintsFromView:(UIView *)oldView toView:(UIView *)newView {
    [newView addConstraints:[self constraintsWitView:oldView newView:newView]];
    [newView.superview addConstraints:[self constraintsWitSuperView:oldView newView:newView]];
}

@end
