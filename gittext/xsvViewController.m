//
//  xsvViewController.m
//  gittext
//
//  Created by Jacob Henry Prather on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvViewController.h"

@interface xsvViewController ()
@property(nonatomic, strong)UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong)xsvAlerter* localAlerter;
@property(nonatomic, strong)xsvStyler* localStyler;
@property(nonatomic, strong)xsvIndicator* localIndicator;
@end

@implementation xsvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localAlerter = [[xsvAlerter alloc]init];
    _localStyler = [[xsvStyler alloc]init];
    _localIndicator = [[xsvIndicator alloc]init];
    [self.view addSubview: [_localIndicator createUIViewIndicator:(self)]];
    [_localStyler styleButton:(_login)];
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
    [[_localAlerter createAlert:(@"Error.") messageText:(@"Invalid credentials, try again.") buttonText:(@"Ok")] show];
}

-(void)authenticate{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:([_username text]) password:([_password text])];
    NSString* url = @"https://@api.github.com/user";
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self successfulAuth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failedAuth];
    }];
}

@end
