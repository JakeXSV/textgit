//
//  xsvIndicator.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "xsvIndicator.h"

@implementation xsvIndicator

-(UIActivityIndicatorView*)createUIViewIndicator:(UIViewController*)view{
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setCenter:(CGPointMake(view.view.frame.size.width / 2.0, view.view.frame.size.height / 2.0))];
    return activityIndicator;
}

@end
