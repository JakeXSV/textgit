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
@property(nonatomic, strong)xsvNetworker* localNetworker;
@end

@implementation xsvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localAlerter = [[xsvAlerter alloc]init];
    _localStyler = [[xsvStyler alloc]init];
    _localIndicator = [[xsvIndicator alloc]init];
    _localNetworker = [[xsvNetworker alloc]init];
    [self.view addSubview: [_localIndicator createUIViewIndicator:(self)]];
    [_localStyler styleButton:(_login)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"successfulAuth"])
    {
        xsvGithubDataController* wc = segue.destinationViewController;
        wc.localNetworker = _localNetworker;
    }
}

-(IBAction)loadApp:(id)sender{
    [_activityIndicator startAnimating];
    [self authenticate];
    [_login setEnabled:(false)];
}

-(void)authenticate{
    [_localNetworker setCredentials:([_username text]) pass:([_password text])];
    AFHTTPRequestOperationManager *manager = [_localNetworker getConfiguredManager];
    NSString* url = [_localNetworker getAuthURL];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self successfulAuth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self failedAuth];
    }];
}

-(void)successfulAuth{
    [_activityIndicator removeFromSuperview];
    [self performSegueWithIdentifier:@"successfulAuth" sender:self];
}

-(void)failedAuth{
    NSLog(@"Failed Auth");
    [_activityIndicator removeFromSuperview];
    [_login setEnabled:(true)];
    [[_localAlerter createAlert:(@"Error.") messageText:(@"Invalid credentials, try again.") buttonText:(@"Ok")] show];
}

@end
