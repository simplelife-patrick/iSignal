//
//  CBQuartzView.h
//  iSignal
//
//  Created by Patrick Deng on 12-4-7.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBQuartzView : UIView

// As a matter of convinience we'll do all of our drawing here in subclasses of QuartzView.
-(void) drawInContext:(CGContextRef)context;

@end
