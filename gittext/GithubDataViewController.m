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
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.repoDictionaryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell configureFlatCellWithColor:[UIColor greenSeaColor]
                       selectedColor:[UIColor cloudsColor]];
    cell.cornerRadius = 5.0f;
    cell.separatorHeight = 2.0f;
    cell.textLabel.text = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"full_name")];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwilioContactViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactView"];
    if([self.currentlyViewing isEqualToString:@"repos"]){
        NSLog(@"%@",[[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"html_url")]);
        view.dataToSend = [[NSString alloc]init];
        view.dataToSend = [[self.repoDictionaryArray objectAtIndex:(indexPath.row)] valueForKeyPath:(@"html_url")];
    }else{
        
    }
    [self presentViewController:view animated:NO completion:nil];
}

@end

