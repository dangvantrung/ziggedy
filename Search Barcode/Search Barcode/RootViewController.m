//
//  RootViewController.m
//  Search Barcode
//
//  Created by Dang Van Trung on 3/14/14.
//  Copyright (c) 2014 Dang Van Trung. All rights reserved.
//

#import "RootViewController.h"

#import "BrowserViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)pressLightButton
{
    [self setIsLight:!self.isLight];
    
    if (self.isLight)
        self.capture.torch = AVCaptureTorchModeOn;
    else
        self.capture.torch = AVCaptureTorchModeOff;
}

- (void)pressCloseButton
{
    [self setIsReady:YES];
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format
{
    switch (format)
    {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if (!result) return;
    
    if (self.isReady == NO) return;
    
    // We got a result. Display information about the result onscreen.
//    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
//    NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
//    [self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:YES];
    
    // Vibrate
    
    [self setIsReady:NO];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    BrowserViewController *browserViewController = [[BrowserViewController alloc] initWithNibName:nil bundle:nil];
    [browserViewController.view setFrame:self.view.bounds];
    [browserViewController setupContent:result.text];
    
    [self presentViewController:browserViewController animated:YES completion:^(void){
        
    }];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setIsLight:NO];
        [self setIsReady:YES];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(pressCloseButton)
         name:@"PRESS_CLOSE_BUTTON"
         object:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect viewFrame = self.view.bounds;
    
    UIImage *lightImage = [UIImage imageNamed:@"light_icon.png"];
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightButton setImage:lightImage forState:UIControlStateNormal];
    [lightButton setFrame:CGRectMake(107, 35, 106, 34)];
    [lightButton addTarget:self action:@selector(pressLightButton)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 234, 234)];
    [scanImageView setCenter:CGPointMake(viewFrame.size.width/2.0, viewFrame.size.height/2.0)];
    [scanImageView setImage:[UIImage imageNamed:@"scan_icon.png"]];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    self.capture.scanRect = scanImageView.frame;
    
    [self.view addSubview:lightButton];
    [self.view addSubview:scanImageView];
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
