//
//  TwilioContactViewController.h
//  gittext
//
//  Created by Jake on 4/8/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"
#import "Styler.h"
#import "Alerter.h"

@interface TwilioContactViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
@property(nonatomic, strong) Networker* localNetworker;
@property(nonatomic, strong) NSString* dataToSend;
@property(nonatomic, weak) IBOutlet UIButton* cancelButton;
@property(nonatomic, weak) IBOutlet UIButton* textGitButton;
@property(nonatomic, weak) IBOutlet UITextView* messageTextView;
@property(nonatomic, weak) IBOutlet UITextField* contactTextField;

-(IBAction)cancel;
-(IBAction)sendMessage;

@end
