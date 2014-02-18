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
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.view;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    
    tabBarItem1.title = @"Home";
    tabBarItem2.title = @"Maps";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
