//
//  Networker.h
//  gittext
//
//  Created by Jake on 2/20/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface Networker : NSObject

@property(nonatomic, strong) NSString* username;
@property(nonatomic, strong) NSString* password;

-(AFHTTPRequestOperationManager*)getGitHubConfiguredManager;
-(AFHTTPRequestOperationManager*)getTwilioConfiguredManager;
-(NSString*)getAuthURL;
-(NSString*)getReposURL;
-(NSString*)getIssuesURL;
-(NSString*)getNotificationsURL;
-(NSString*)getTwilioSMSURL;
-(NSString*)getTwilioFromNumber;
-(void)setCredentials:(NSString*)username pass:(NSString*)pwd;

@end
