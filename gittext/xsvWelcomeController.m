//
//  xsvWelcomeController.m
//  gittext
//
//  Created by jprather on 2/17/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvWelcomeController.h"

@interface xsvWelcomeController()

@end

@implementation xsvWelcomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"HIT WELCOME CONTROLLER");

    _repoTab = [self.tabBar.items objectAtIndex:0];
    _notificationTab = [self.tabBar.items objectAtIndex:1];
    
    _repoTab.title = @"Repositories";
    _notificationTab.title = @"Notifications";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
