//
//  ViewController.h
//  gittext
//
//  Created by Jacob Henry Prather on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import "AFNetworking.h"
#import "Alerter.h"
#import "Styler.h"
#import "Indicator.h"
#import "GithubDataViewController.h"
#import "Networker.h"

@interface LoginViewController : UIViewController

@property(nonatomic, weak) IBOutlet FUIButton* login;
@property(nonatomic, weak) IBOutlet FUITextField* username;
@property(nonatomic, weak) IBOutlet FUITextField* password;

-(IBAction)loadApp:(id)sender;

@end
