//
//  GithubDataViewController
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "GithubDataViewController.h"
#import "TwilioContactViewController.h"

NSString *const CellIdentifier          = @"DataCell";
NSString *const TabBarNotificationsId   = @"Notifications";
NSString *const TabBarRepositoriesId    = @"Repositories";
NSString *const FontForCells            = @"HelveticaNeue";
NSString *const TwilioContactViewId     = @"ContactView";

@interface GithubDataViewController ()
@property(nonatomic, strong) NSString* currentlyViewing;
@end

@implementation GithubDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeLocalData];
    [self initializeDelegatee];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Initializers

-(void)initializeLocalData{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.currentlyViewing = TabBarRepositoriesId;
}

-(void)initializeDelegatee{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBar.delegate = self;
}

#pragma mark - Table View Delegate/DS

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
    
    [cell configureFlatCellWithColor:[UIColor greenSeaColor] selectedColor:[UIColor cloudsColor]];
    cell.cornerRadius = 5.0f;
    cell.separatorHeight = 2.0f;
    
    if([self.currentlyViewing isEqualToString:TabBarRepositoriesId]){
        
        [cell.textLabel setFont:([UIFont fontWithName:FontForCells size:17])];
        cell.textLabel.text = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"full_name")];
        
    }else if([self.currentlyViewing isEqualToString:TabBarNotificationsId]){
        
        [cell.textLabel setFont:([UIFont fontWithName:FontForCells size:10])];
        cell.textLabel.numberOfLines = 0;
        NSString* notification = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"subject")] valueForKeyPath:(@"title")];
        NSString* project = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"repository")] valueForKeyPath:(@"name")];
        NSString* newLine = @":\n";
        cell.textLabel.text = [project stringByAppendingString:([newLine stringByAppendingString:(notification)])];
        
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
    
    if([self.currentlyViewing isEqualToString:TabBarRepositoriesId]){
        view.dataToSend = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"html_url")];
    }else if([self.currentlyViewing isEqualToString:TabBarNotificationsId]){
        NSString* apiUrlVersion = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKey:(@"subject")] valueForKey:@"url"];
        NSString* fixedUrl = [self decodeAPIVersionOfURL:[[NSURL alloc] initWithString:apiUrlVersion]];
        view.dataToSend = fixedUrl;
    }else{
        view.dataToSend = @"";
    }
    
    [self presentViewController:view animated:NO completion:nil];
}

# pragma mark - Local Helper Functions

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

@end

