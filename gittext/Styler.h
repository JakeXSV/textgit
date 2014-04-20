//
//  Styler.h
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>

@interface Styler : NSObject

-(void)styleButton:(FUIButton*)button;
-(void)styleSegmentedControl:(FUISegmentedControl*)segControl;
-(void)styleTableCell:(UITableViewCell*)cell;

@end
