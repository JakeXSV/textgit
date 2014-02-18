//
//  xsvViewController.m
//  gittext
//
//  Created by Jacob Henry Prather on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvViewController.h"
#import "AFNetworking.h"
#import "CJSONDeserializer.h"
#include "NSDictionary_JSONExtensions.h"

@interface xsvViewController ()
@property(nonatomic, strong)UIActivityIndicatorView* activityIndicator;
@end

@implementation xsvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: _activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadApp:(id)sender{
    [_activityIndicator startAnimating];
    [self authenticate];
    [_login setEnabled:(false)];
}

-(void)successfulAuth{
    [self performSegueWithIdentifier:@"successfulAuth" sender:self];
}

-(void)failedAuth{
    NSLog(@"Failed Auth");
    [_activityIndicator removeFromSuperview];
    [_login setEnabled:(true)];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                    message:@"The credentials you provided are incorrect."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert removeFromSuperview];
}

-(void)authenticate{
    NSString* user = [_username text];
    NSString* pwd = [_password text];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:user password:pwd];
    NSString* url = @"https://@api.github.com/user";
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successfulAuth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failedAuth];
    }];
}

@end
