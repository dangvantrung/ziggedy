//
//  BrowserViewController.m
//  Search Barcode
//
//  Created by Dang Van Trung on 3/16/14.
//  Copyright (c) 2014 Dang Van Trung. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)pressCloseButton
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"PRESS_CLOSE_BUTTON"
     object:nil];
}

- (void)setupContent:(NSString *)barcodeId
{
//    /** clear content of webview */
//    NSString *blankString = [NSString stringWithFormat:@"about:blank"];
//    
//    NSURLRequest *blankrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:blankString]] ;
//    
//    [self.webView loadRequest:blankrequest] ;

    /** load new content for webview */
    NSString *requestString = [NSString stringWithFormat:@"http://scan.me/products/upc-a:%@", barcodeId];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]] ;
    
    [self.webView loadRequest:request] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        CGRect viewFrame = self.view.bounds;
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        UIImage *closeImage = [UIImage imageNamed:@"close_icon.png"];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:closeImage forState:UIControlStateNormal];
        [closeButton setFrame:CGRectMake(270, 0, 50, 50)];
        [closeButton addTarget:self action:@selector(pressCloseButton)
              forControlEvents:UIControlEventTouchUpInside];

        self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                      initWithActivityIndicatorStyle:
                                      UIActivityIndicatorViewStyleGray];
        [self.activityIndicatorView setCenter:CGPointMake(viewFrame.size.width/2.0,
                                                          viewFrame.size.height/2.0+50.0)];
        [self.activityIndicatorView setHidesWhenStopped:YES];
        [self.activityIndicatorView startAnimating];
        
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50,
                                                                   viewFrame.size.width,
                                                                   viewFrame.size.height-50)];
        [self.webView setDelegate:self];
        
        [self.view addSubview:self.webView];
        [self.view addSubview:self.activityIndicatorView];
        
        [self.view addSubview:closeButton];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
