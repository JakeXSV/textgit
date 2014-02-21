//
//  xsvGithubDataController.h
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import <AFNetworking.h>
#import "xsvAlerter.h"
#import "xsvStyler.h"
#import "xsvIndicator.h"
#import "xsvNetworker.h"

@interface xsvGithubDataController : UIViewController

@property(nonatomic, weak) IBOutlet FUISegmentedControl* segControl;
@property(nonatomic, strong) xsvNetworker* localNetworker;

@end
