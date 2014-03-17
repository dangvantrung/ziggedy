//
//  BrowserViewController.h
//  Search Barcode
//
//  Created by Dang Van Trung on 3/16/14.
//  Copyright (c) 2014 Dang Van Trung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

- (void)setupContent:(NSString *)barcodeId;

@end
