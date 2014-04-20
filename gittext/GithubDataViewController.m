//
//  WelcomeController.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "GithubDataViewController.h"
#import "TwilioContactViewController.h"

@interface GithubDataViewController ()
@property(nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong) Alerter* localAlerter;
@property(nonatomic, strong) Styler* localStyler;
@property(nonatomic, strong) Indicator* localIndicator;
@property(nonatomic, strong) NSString* currentlyViewing;
@end

@implementation GithubDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _localStyler = [[Styler alloc]init];
    self.currentlyViewing = @"repos";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBar.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.currentlyViewing isEqualToString:@"repos"]){
        return self.repoDictionaryArray.count;
    }else if([self.currentlyViewing isEqualToString:@"notifications"]){
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
    if([self.currentlyViewing isEqualToString:@"repos"]){
        [cell.textLabel setFont:([UIFont fontWithName:@"HelveticaNeue" size:17])];
        cell.textLabel.text = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"full_name")];
    }else if([self.currentlyViewing isEqualToString:@"notifications"]){
        [cell.textLabel setFont:([UIFont fontWithName:@"HelveticaNeue" size:10])];
        cell.textLabel.numberOfLines = 0;
        NSString* notification = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"subject")] valueForKeyPath:(@"title")];
        NSString* project = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"repository")] valueForKeyPath:(@"name")];
        NSString* newLine = @":\n";
        cell.textLabel.text = [project stringByAppendingString:([newLine stringByAppendingString:(notification)])];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwilioContactViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactView"];
    
    if([self.currentlyViewing isEqualToString:@"repos"]){
        view.dataToSend = [[NSString alloc]init];
        view.dataToSend = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"html_url")];
    }else{
        NSString* apiUrlVersion = [[[self.notificationDictionaryArray objectAtIndex:(indexPath.row)] valueForKey:(@"subject")] valueForKey:@"url"];
        NSString* fixedUrl = [self decodeAPIVersionOfURL:[[NSURL alloc] initWithString:apiUrlVersion]];
        view.dataToSend = [[NSString alloc]init];
        view.dataToSend = fixedUrl;
    }
    
    [self presentViewController:view animated:NO completion:nil];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([[item title] isEqualToString:(@"Repository")]){
        self.currentlyViewing = @"repos";
    }else if([[item title] isEqualToString:(@"Notifications")]){
        self.currentlyViewing = @"notifications";
    }else{
        NSLog(@"Error during tab bar selection");
    }
    [self.tableView reloadData];
}

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

