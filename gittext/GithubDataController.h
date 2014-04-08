//
//  GithubDataController.h
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import <AFNetworking.h>
#import "Alerter.h"
#import "Styler.h"
#import "Indicator.h"
#import "Networker.h"

@interface GithubDataController : UIViewController

@property(nonatomic, weak) IBOutlet FUISegmentedControl* segControl;
@property(nonatomic, strong) Networker* localNetworker;

@end
