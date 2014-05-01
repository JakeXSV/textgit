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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

# pragma Initializers

-(void)initializeLocalData{
    self.localStyler = [[Styler alloc]init];
    self.localAlerter = [[Alerter alloc]init];
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

-(void)dismissKeyboard {
    [self.messageTextView resignFirstResponder];
}

# pragma SMS handling

-(IBAction)sendMessage{
    if([self validPhoneNumber] && [self validMessage]){
        AFHTTPRequestOperationManager *manager = [self.localNetworker getTwilioConfiguredManager];
        NSDictionary *parameters = @{@"Body": self.messageTextView.text, @"To": self.contactTextField.text, @"From": [self.localNetworker getTwilioFromNumber]};
        [manager POST:[self.localNetworker getTwilioSMSURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [[self.localAlerter createAlert:(@"Error.") messageText:(@"Invalid phone number or message.") buttonText:(@"Ok")] show];
    }
}

-(IBAction)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)validPhoneNumber{
    return (self.contactTextField.text.length == 10 && ![self.contactTextField.text isEqualToString:@"911"]);
}

-(BOOL)validMessage{
    return self.messageTextView.text.length>0;
}

@end
