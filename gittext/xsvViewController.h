//
//  xsvViewController.h
//  gittext
//
//  Created by Jacob Henry Prather on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xsvViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIButton* login;
@property(nonatomic, weak) IBOutlet UITextField* username;
@property(nonatomic, weak) IBOutlet UITextField* password;

-(IBAction)loadApp:(id)sender;

@end
