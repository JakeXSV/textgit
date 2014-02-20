//
//  xsvWelcomeController.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvWelcomeController.h"

@interface xsvWelcomeController ()
@property(nonatomic, strong)UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong)xsvAlerter* localAlerter;
@property(nonatomic, strong)xsvStyler* localStyler;
@property(nonatomic, strong)xsvIndicator* localIndicator;
@end

@implementation xsvWelcomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"HIT WELCOME IMPL");
    _localStyler = [[xsvStyler alloc]init];
    [_localStyler styleSegmentedControl:(_segControl)];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



@end

