//
//  WelcomeController.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "GithubDataController.h"

@interface GithubDataController ()
@property(nonatomic, strong)UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong)Alerter* localAlerter;
@property(nonatomic, strong)Styler* localStyler;
@property(nonatomic, strong)Indicator* localIndicator;
@end

@implementation GithubDataController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localStyler = [[Styler alloc]init];
    [_localStyler styleSegmentedControl:(_segControl)];
    [self getRepos];
}

-(void)getRepos{
    AFHTTPRequestOperationManager *manager = [_localNetworker getConfiguredManager];
    NSLog(@"details - %@ %@", _localNetworker.username, _localNetworker.password);
    NSString* url = [_localNetworker getReposURL];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end

