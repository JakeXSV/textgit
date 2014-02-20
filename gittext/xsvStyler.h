//
//  xsvStyler.h
//  gittext
//
//  Created by Jake on 2/19/14.
//  Copyright (c) 2014 jprather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FlatUIKit.h>

@interface xsvStyler : NSObject

-(void)styleButton:(FUIButton*)button;
-(void)styleSegmentedControl:(FUISegmentedControl*)segControl;

@end
