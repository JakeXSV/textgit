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
	// Do any additional setup after loading the view.
    self.localStyler = [[Styler alloc]init];
    self.localNetworker = [[Networker alloc]init];
    self.localAlerter = [[Alerter alloc]init];
    self.contactTextField.delegate = self;
    self.messageTextView.delegate = self;
    self.messageTextView.text = [self.dataToSend stringByAppendingString:@" <- check this out!"];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendMessage{
    
    AFHTTPRequestOperationManager *manager = [self.localNetworker getTwilioConfiguredManager];
    NSDictionary *parameters = @{@"Body": self.messageTextView.text, @"To": self.contactTextField.text, @"From": [self.localNetworker getTwilioFromNumber]};
    [manager POST:[self.localNetworker getTwilioSMSURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.localAlerter createAlert:@"Success" messageText:@"Message sent." buttonText:@":)"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.localAlerter createAlert:@"Error" messageText:@"Failed to send message." buttonText:@":("];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(IBAction)cancel{
    NSLog(@"cancel message");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

@end
