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
    _localAlerter = [[xsvAlerter alloc]init];
    _localStyler = [[xsvStyler alloc]init];
    _localIndicator = [[xsvIndicator alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

