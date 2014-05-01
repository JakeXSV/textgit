//
//  LoginViewController
//  gittext
//
//  Created by Jake on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "LoginViewController.h"

NSString *const SegueToGitHubDataView = @"successfulAuth";

@interface LoginViewController ()
@property(nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong) Alerter* localAlerter;
@property(nonatomic, strong) Styler* localStyler;
@property(nonatomic, strong) Indicator* localIndicator;
@property(nonatomic, strong) Networker* localNetworker;
@property(nonatomic, strong) NSMutableArray* tempRepos;
@property(nonatomic, strong) NSMutableArray* tempNotifications;
@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self initializeLocalData];
    [self initializeStyles];
    [self.view addSubview: [self.localIndicator createUIViewIndicator:(self)]];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - Initializers

-(void)initializeLocalData{
    self.tempRepos = [[NSMutableArray alloc]init];
    self.tempNotifications = [[NSMutableArray alloc]init];
    self.localAlerter = [[Alerter alloc]init];
    self.localStyler = [[Styler alloc]init];
    self.localIndicator = [[Indicator alloc]init];
    self.localNetworker = [[Networker alloc]init];
}

-(void)initializeStyles{
    [self.localStyler styleButton:(self.login)];
}

# pragma mark - Authentication & Data Retrieval
//authenticate (on success) -> get repo data (on success) -> get notification data (on success) -> load new view

-(IBAction)loadApp:(id)sender{
    [self.activityIndicator startAnimating];
    [self authenticate];
    [self.login setEnabled:(false)];
}

-(void)authenticate{
    [self.localNetworker setCredentials:([self.username text]) pass:([self.password text])];
    AFHTTPRequestOperationManager *manager = [self.localNetworker getGitHubConfiguredManager];
    NSString* url = [self.localNetworker getAuthURL];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getRepoData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self failedAuth];
    }];
}

-(void)failedAuth{
    [self.activityIndicator removeFromSuperview];
    [self.login setEnabled:(true)];
    [[self.localAlerter createAlert:(@"Error.") messageText:(@"Invalid credentials, try again.") buttonText:(@"Ok")] show];
}

-(void)getRepoData{
    AFHTTPRequestOperationManager *manager = [self.localNetworker getGitHubConfiguredManager];
    [manager GET:[self.localNetworker getReposURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //NSCFArray -> NSMutableArray
        for (int i=0; i<[responseObject count]; i++) { [self.tempRepos addObject:([responseObject objectAtIndex:(i)])]; }
        [self getNotificationData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.activityIndicator removeFromSuperview];
    }];
}

-(void)getNotificationData{
    AFHTTPRequestOperationManager *manager = [self.localNetworker getGitHubConfiguredManager];
    [manager GET:[self.localNetworker getNotificationsURL] parameters:@{@"all":@"true"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //NSCFArray -> NSMutableArray
        for (int i=0; i<[responseObject count]; i++) { [self.tempNotifications addObject:([responseObject objectAtIndex:(i)])]; }
        [self performSegueWithIdentifier:SegueToGitHubDataView sender:self];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.activityIndicator removeFromSuperview];
    }];
}

# pragma mark - Transition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueToGitHubDataView])
    {
        GithubDataViewController* wc = segue.destinationViewController;
        wc.repoDictionaryArray = self.tempRepos;
        wc.notificationDictionaryArray = self.tempNotifications;
        wc.localNetworker = self.localNetworker;
    }
    [self.activityIndicator removeFromSuperview];
}

@end
