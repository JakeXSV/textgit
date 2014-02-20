//
//  xsvStyler.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvStyler.h"

@implementation xsvStyler

-(void)styleButton:(FUIButton*)button{
    button.buttonColor = [UIColor turquoiseColor];
    button.shadowColor = [UIColor greenSeaColor];
    button.shadowHeight = 3.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

-(void)styleSegmentedControl:(FUISegmentedControl*)segControl UITableViewController:(UITableViewController*)view{
    [segControl setFrame:CGRectMake(0, 0, CGRectGetWidth(segControl.bounds), 44)];
}

@end
