//
//  xsvViewController.m
//  gittext
//
//  Created by Jacob Henry Prather on 2/13/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvViewController.h"

@interface xsvViewController ()

@end

@implementation xsvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadApp:(id)sender{
    NSLog(@"HIT");
    if([self isValidGithub]){
        [self performSegueWithIdentifier:@"successfulAuth" sender:self];
    }else{
        
    }
}

-(BOOL)isValidGithub{
    NSString* user = [_username text];
    NSString* pwd = [_password text];
    NSLog(@"%@",user);
    NSLog(@"%@",pwd);
    return false;
}

@end
