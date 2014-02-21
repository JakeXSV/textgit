//
//  xsvNetworker.h
//  gittext
//
//  Created by Jake on 2/20/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface xsvNetworker : NSObject

@property(nonatomic, strong) NSString* username;
@property(nonatomic, strong) NSString* password;

-(AFHTTPRequestOperationManager*)getConfiguredManager;
-(NSString*)getAuthURL;
-(NSString*)getReposURL;
-(NSString*)getCommitsURL;
-(NSString*)getNotificationsURL;
-(void)setCredentials:(NSString*)username pass:(NSString*)pwd;

@end
