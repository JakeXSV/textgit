//
//  TwilioContactViewController.m
//  gittext
//
//  Created by Jake on 4/8/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "TwilioContactViewController.h"
#import "Styler.h"
#import "Networker.h"

@interface TwilioContactViewController ()
@property(nonatomic, strong) Styler* localStyler;
@property(nonatomic, strong) Alerter* localAlerter;
@end

@implementation TwilioContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeLocalData];
    [self initializeStyles];
    [self initializeDelegatee];
    self.messageTextView.text = [self.dataToSend stringByAppendingString:@" <- check this out!"];
}

# pragma Initializers

-(void)initializeLocalData{
    self.localStyler = [[Styler alloc]init];
    self.localNetworker = [[Networker alloc]init];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)initializeStyles{
    [self.localStyler styleButton:self.textGitButton];
    [self.localStyler styleButton:self.cancelButton];
}

-(void)initializeDelegatee{
    self.contactTextField.delegate = self;
    self.messageTextView.delegate = self;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

# pragma SMS handling

-(IBAction)sendMessage{
    AFHTTPRequestOperationManager *manager = [self.localNetworker getTwilioConfiguredManager];
    NSDictionary *parameters = @{@"Body": self.messageTextView.text, @"To": self.contactTextField.text, @"From": [self.localNetworker getTwilioFromNumber]};
    [manager POST:[self.localNetworker getTwilioSMSURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
