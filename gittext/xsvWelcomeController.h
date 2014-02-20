//
//  xsvWelcomeController.h
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import "xsvAlerter.h"
#import "xsvStyler.h"
#import "xsvIndicator.h"

@interface xsvWelcomeController : UITableViewController

@property(nonatomic, weak) IBOutlet FUISegmentedControl* segControl;

@end
