//
//  CBUIUtils.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "CBUIUtils.h"

@implementation CBUIUtils

// Manual Codes Begin

+(id<UIApplicationDelegate>) getAppDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

+(UIWindow*) getKeyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+(UIWindow*) getWindow:(UIView *)view
{
    if (nil == view) 
    {
        DLog(@"Parameter UIView* view is nil");
        return nil;
    }
    else
    {
        for (UIView* nextView = view; nextView; nextView = nextView.superview)
        {
            if([nextView isKindOfClass:[UIWindow class]])
            {
                return (UIWindow*) nextView;
            }
        }
        DLog(@"Can't find window for this view: %@", view);
        return nil;        
    }
}

+(UIViewController*) getViewControllerFromView:(UIView *)view
{
    if(nil == view)
    {
        DLog(@"Parameter UIView* view is nil.");
        return nil;
    }
    else
    {
        for (UIView* nextView = view; nextView; nextView = nextView.superview)
        {
            UIResponder *nextResponder = [nextView nextResponder];
            
            if([nextResponder isKindOfClass:[UIViewController class]])
            {
                return (UIViewController*) nextResponder;
            }
        }
        DLog(@"Can't find controller for this view: %@", view);
        return nil;
    }
}

- (void)dealloc
{
    [super dealloc];
}

// Manual Codes End

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

@end
