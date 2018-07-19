//
//  SecondViewController.m
//  WKWebView-Print
//
//  http://github.com/sergemoskalenko/WKWebView-Print-Simple
//  Created by Serge Moskalenko on 19.07.2018.
//  Copyright © 2018 Serge Moskalenko. All rights reserved.
//

#import "SecondViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+Print.h"
#import "NSLayoutConstraint+Copy.h"

@interface SecondViewController ()  <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextView;
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WKWebViewConfiguration* configuration = [WKWebViewConfiguration new];
    WKUserScript* script = [[WKUserScript alloc] initWithSource:@"window.print = function() { window.webkit.messageHandlers.print.postMessage('print') }" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:script];
    [configuration.userContentController addScriptMessageHandler:(id <WKScriptMessageHandler>)self name:@"print"];
    
    WKWebView* webViewNew = [[WKWebView alloc] initWithFrame:_webView.frame configuration:configuration];
    webViewNew.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:webViewNew];
    [NSLayoutConstraint copyConstraintsFromView:_webView toView:webViewNew];
    [_webView removeFromSuperview];
    self.webView = webViewNew;
    
    _urlTextView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if([self.urlTextView.text isEqualToString:@""]) {
        self.urlTextView.text = @"http://picree.com/ex/print/";
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

#pragma mark - Print

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
 
    [self printWebView];
}
- (void)printWebView{
    [self printTitle:_urlTextView.text webView:_webView];
}

@end
