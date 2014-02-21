//
//  xsvNetworker.m
//  gittext
//
//  Created by Jake on 2/20/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvNetworker.h"

@implementation xsvNetworker


-(AFHTTPRequestOperationManager*)getConfiguredManager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:(_username) password:(_password)];
    return manager;
}

-(void)setCredentials:(NSString*)username pass:(NSString*)pwd{
    _username = username;
    _password = pwd;
}

-(NSString*)getAuthURL{
    return @"https://api.github.com/user";
}

-(NSString*)getReposURL{
    return @"https://api.github.com/user/repos";
}

-(NSString*)getNotificationsURL{
    return @"https://api.github.com/notifications";
}

-(NSString*)getCommitsURL{
    return @"";
}

@end
