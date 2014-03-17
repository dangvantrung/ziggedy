//
//  RootViewController.h
//  Search Barcode
//
//  Created by Dang Van Trung on 3/14/14.
//  Copyright (c) 2014 Dang Van Trung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "ZXingObjC.h"

@interface RootViewController : UIViewController <ZXCaptureDelegate>

@property (nonatomic) BOOL isReady;
@property (nonatomic) BOOL isLight;

@property (nonatomic, strong) ZXCapture *capture;

@end
