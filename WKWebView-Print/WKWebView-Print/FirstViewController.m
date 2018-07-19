//
//  FirstViewController.m
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

#import "FirstViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+Print.h"

@interface FirstViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextView;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *printButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _urlTextView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if([self.urlTextView.text isEqualToString:@""]) {
        self.urlTextView.text = @"http://me.com";
        [self editingDidEndTextView:_urlTextView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; // Dismiss the keyboard.
    // Execute any additional code
    
    NSString* urlText = textField.text;
    if (![urlText isEqualToString:@""]) {
        if (![urlText hasPrefix:@"http://"] && ![urlText hasPrefix:@"https://"])
            textField.text = [NSString stringWithFormat:@"http://%@", urlText];
        [self editingDidEndTextView:textField];
    }
    
    return YES;
}

- (IBAction)editingDidEndTextView:(UITextField *)sender {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextView.text]];
    [self.webView loadRequest:request];
}

- (IBAction)printButtonAction:(UIButton *)sender {
    [self printTitle:_urlTextView.text webView:_webView];
}

@end
