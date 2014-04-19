//
//  ViewController.m
//  gittext
//
//  Created by Jake on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic, strong)UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong)Alerter* localAlerter;
@property(nonatomic, strong)Styler* localStyler;
@property(nonatomic, strong)Indicator* localIndicator;
@property(nonatomic, strong)Networker* localNetworker;
@property(nonatomic, strong)NSMutableArray* tempRepos;
@property(nonatomic, strong)NSMutableArray* tempCommits;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.tempRepos = [[NSMutableArray alloc]init];
    self.tempCommits = [[NSMutableArray alloc]init];
    _localAlerter = [[Alerter alloc]init];
    _localStyler = [[Styler alloc]init];
    _localIndicator = [[Indicator alloc]init];
    _localNetworker = [[Networker alloc]init];
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
        GithubDataViewController* wc = segue.destinationViewController;
        wc.localNetworker = _localNetworker;
        wc.repoDictionaryArray = self.tempRepos;
    }
}

-(IBAction)loadApp:(id)sender{
    [_activityIndicator startAnimating];
    [self authenticate];
    [_login setEnabled:(false)];
}

-(void)authenticate{
    [_localNetworker setCredentials:([_username text]) pass:([_password text])];
    AFHTTPRequestOperationManager *manager = [_localNetworker getGitHubConfiguredManager];
    NSString* url = [_localNetworker getAuthURL];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        [self successfulAuth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self failedAuth];
    }];
}

-(void)successfulAuth{
    [self getRepoData];
}

-(void)failedAuth{
    NSLog(@"Failed Auth");
    [_activityIndicator removeFromSuperview];
    [_login setEnabled:(true)];
    [[_localAlerter createAlert:(@"Error.") messageText:(@"Invalid credentials, try again.") buttonText:(@"Ok")] show];
}

-(void)getRepoData{
    AFHTTPRequestOperationManager *manager = [_localNetworker getGitHubConfiguredManager];
    NSString* url = [_localNetworker getReposURL];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        int i = 0;
        for (i=0; i<[responseObject count]; i++) {
            [self.tempRepos addObject:([responseObject objectAtIndex:(i)])];
        }
        [_activityIndicator removeFromSuperview];
        [self performSegueWithIdentifier:@"successfulAuth" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_activityIndicator removeFromSuperview];
    }];
}

@end
