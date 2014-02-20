//
//  xsvWelcomeController.h
//  gittext
//
//  Created by jprather on 2/17/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xsvWelcomeController : UITabBarController

@property(nonatomic, weak) IBOutlet UITabBarController* tabController;
@property(nonatomic, weak) IBOutlet UITabBarItem* repoTab;
@property(nonatomic, weak) IBOutlet UITabBarItem* notificationTab;

@end
