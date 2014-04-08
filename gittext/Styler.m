//
//  Styler.m
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import "Styler.h"

@implementation Styler

-(void)styleButton:(FUIButton*)button{
    button.buttonColor = [UIColor turquoiseColor];
    button.shadowColor = [UIColor greenSeaColor];
    button.shadowHeight = 3.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

-(void)styleSegmentedControl:(FUISegmentedControl*)segControl{
    segControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    segControl.selectedFontColor = [UIColor cloudsColor];
    
    segControl.deselectedFont = [UIFont flatFontOfSize:16];
    segControl.deselectedFontColor = [UIColor cloudsColor];
    
    segControl.selectedColor = [UIColor greenSeaColor];
    segControl.deselectedColor = [UIColor turquoiseColor];
    
    segControl.dividerColor = [UIColor midnightBlueColor];
    segControl.cornerRadius = 15;
}

@end
