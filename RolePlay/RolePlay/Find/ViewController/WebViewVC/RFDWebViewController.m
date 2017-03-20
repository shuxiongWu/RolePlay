//
//  RFDWebViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDWebViewController.h"

@interface RFDWebViewController ()<UIWebViewDelegate>

@end

@implementation RFDWebViewController
- (id) init
{
    if (self = [super init]) {
        _webView = [[UIWebView alloc] init];
        [_webView setDelegate:self];
        [_webView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_webView];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_webView setFrame:CGRectMake(0, 0, self.view.frameWidth, self.view.frameHeight)];
}

- (void) setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navigationItem setTitle:title];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

@end
