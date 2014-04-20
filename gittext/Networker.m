//
//  Networker.m
//  gittext
//
//  Created by Jake on 2/20/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "Networker.h"

NSString *const GitHubAPIBase               = @"https://api.github.com";
NSString *const GitHubAuthEndpoint          = @"/user";
NSString *const GitHubReposEndpoint         = @"/user/repos";
NSString *const GitHubNotificationsEndpoint = @"/notifications";
NSString *const GitHubIssuesEndpoint        = @"/issues";

NSString *const TwilioAPIBase       = @"https://api.twilio.com/2010-04-01/Accounts/";
NSString *const TwilioSMSEndpoint   = @"/Messages.json";
NSString *const TwilioSID           = @"";
NSString *const TwilioAuth          = @"";
NSString *const TwilioNumber        = @"";

@implementation Networker

-(AFHTTPRequestOperationManager*)getGitHubConfiguredManager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:(_username) password:(_password)];
    return manager;
}

-(AFHTTPRequestOperationManager*)getTwilioConfiguredManager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:TwilioSID password:TwilioAuth];
    return manager;
}

-(void)setCredentials:(NSString*)username pass:(NSString*)pwd{
    _username = username;
    _password = pwd;
}

-(NSString*)getAuthURL{
    return [GitHubAPIBase stringByAppendingString:GitHubAuthEndpoint];
}

-(NSString*)getReposURL{
    return [GitHubAPIBase stringByAppendingString:GitHubReposEndpoint];
}

-(NSString*)getNotificationsURL{
    return [GitHubAPIBase stringByAppendingString:GitHubNotificationsEndpoint];
}

-(NSString*)getIssuesURL{
    return [GitHubAPIBase stringByAppendingString:GitHubIssuesEndpoint];
}

-(NSString*)getTwilioSMSURL{
    return [[TwilioAPIBase stringByAppendingString:(TwilioSID)] stringByAppendingString: TwilioSMSEndpoint];
}

-(NSString*)getTwilioFromNumber{
    return TwilioNumber;
}

@end
