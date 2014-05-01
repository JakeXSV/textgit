//
//  GithubDataViewController
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "GithubDataViewController.h"
#import "TwilioContactViewController.h"
#import "Styler.h"

NSString *const CellIdentifier          = @"DataCell";
NSString *const TabBarNotificationsId   = @"Notifications";
NSString *const TabBarRepositoriesId    = @"Repositories";
NSString *const FontForCells            = @"HelveticaNeue";
NSString *const TwilioContactViewId     = @"ContactView";

@interface GithubDataViewController ()
@property(nonatomic, strong) NSString* currentlyViewing;
@property(nonatomic, strong) Styler* localStyler;
@property(nonatomic, strong) UIRefreshControl* refreshControl;
@end

@implementation GithubDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeLocalData];
    [self initializeDelegatee];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Initializers

-(void)initializeLocalData{
    self.localStyler = [[Styler alloc]init];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.currentlyViewing = TabBarRepositoriesId;
}

-(void)initializeDelegatee{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBar.delegate = self;
}

#pragma mark - Table View Delegate/DS

- (void)refreshTable {
        AFHTTPRequestOperationManager *manager = [self.localNetworker getGitHubConfiguredManager];
        [manager GET:[self.localNetworker getReposURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.repoDictionaryArray = [[NSMutableArray alloc]init];
            for (int i=0; i<[responseObject count]; i++) { [self.repoDictionaryArray addObject:([responseObject objectAtIndex:(i)])]; }
            [manager GET:[self.localNetworker getNotificationsURL] parameters:@{@"all":@"true"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.notificationDictionaryArray = [[NSMutableArray alloc]init];
                for (int i=0; i<[responseObject count]; i++) { [self.notificationDictionaryArray addObject:([responseObject objectAtIndex:(i)])]; }
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.currentlyViewing isEqualToString:TabBarRepositoriesId]){
        return self.repoDictionaryArray.count;
    }else if([self.currentlyViewing isEqualToString:TabBarNotificationsId]){
        return self.notificationDictionaryArray.count;
    }else{
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self.localStyler styleTableCell:cell];
    
    if([self.currentlyViewing isEqualToString:TabBarRepositoriesId])
    {
        [cell.textLabel setFont:([UIFont fontWithName:FontForCells size:17])];
        cell.textLabel.text = [self getRepositoryName:[self.repoDictionaryArray objectAtIndex:(indexPath.row)]];
    }
    else if([self.currentlyViewing isEqualToString:TabBarNotificationsId])
    {
        [cell.textLabel setFont:([UIFont fontWithName:FontForCells size:10])];
        cell.textLabel.numberOfLines = 0; //allow for multiple lines in single textviewcell label
        cell.textLabel.text = [self getNotificationText:[self.notificationDictionaryArray objectAtIndex:(indexPath.row)]];
    }
    return cell;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([[item title] isEqualToString:(TabBarRepositoriesId)])
    {
        self.currentlyViewing = TabBarRepositoriesId;
    }
    else if([[item title] isEqualToString:(TabBarNotificationsId)])
    {
        self.currentlyViewing = TabBarNotificationsId;
    }else{
        NSLog(@"Error during tab bar selection");
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

# pragma mark - Table View Delegatee Event & Transition

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwilioContactViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:TwilioContactViewId];
    view.dataToSend = [[NSString alloc]init];
    
    if([self.currentlyViewing isEqualToString:TabBarRepositoriesId])
    {
        view.dataToSend = [self getDataToSendFromRepository:[self.repoDictionaryArray objectAtIndex:(indexPath.row)]];
    }
    else if([self.currentlyViewing isEqualToString:TabBarNotificationsId])
    {
        NSString* apiUrlVersion = [self getDataToSendFromNotification:[self.notificationDictionaryArray objectAtIndex:(indexPath.row)]];
        NSString* fixedUrl = [self decodeAPIVersionOfURL:[[NSURL alloc] initWithString:apiUrlVersion]];
        view.dataToSend = fixedUrl;
    }else{
        view.dataToSend = @"";
    }
    
    [self presentViewController:view animated:NO completion:nil];
}

# pragma mark - Local Helper Functions + Dictionary Work

-(NSString*)decodeAPIVersionOfURL:(NSURL*)url{
    NSString* protocol = url.scheme;
    NSString* slashes = @"://";
    NSString* fixedHost = [url.host stringByReplacingOccurrencesOfString:@"api." withString:@""];
    NSString* restOfPath = @"/";
    int i = 2;
    for (i=2; i<url.pathComponents.count; i++) {
        restOfPath = [[restOfPath stringByAppendingString:url.pathComponents[i]] stringByAppendingString:@"/"];
    }
    restOfPath = [restOfPath substringToIndex:restOfPath.length-1];
    return [[[[@"" stringByAppendingString:protocol] stringByAppendingString:slashes] stringByAppendingString:fixedHost] stringByAppendingString:restOfPath];
}

-(NSString*)getNotificationText:(NSDictionary*)item{
    NSString* notification = [self getNotificationTitle:item];
    NSString* project = [self getNotificationProject:item];
    NSString* newLine = @":\n";
    return [project stringByAppendingString:([newLine stringByAppendingString:(notification)])];
}

-(NSString*)getNotificationTitle:(NSDictionary*)item{
    return [[item valueForKeyPath:@"subject"] valueForKeyPath:@"title"];
}

-(NSString*)getNotificationProject:(NSDictionary*)item{
    return [[item valueForKeyPath:(@"repository")] valueForKeyPath:(@"name")];
}

-(NSString*)getRepositoryName:(NSDictionary*)item{
    return [item valueForKeyPath:(@"full_name")];
}

-(NSString*)getDataToSendFromRepository:(NSDictionary*)item{
    return [item valueForKeyPath:(@"html_url")];
}

-(NSString*)getDataToSendFromNotification:(NSDictionary*)item{
    return [[item valueForKey:(@"subject")] valueForKey:@"url"];
}

@end

