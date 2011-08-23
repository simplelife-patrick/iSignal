//
//  ISUIUtils.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISUIUtils.h"

@implementation ISUIUtils

// Manual Codes Begin

+(UIViewController*) getViewControllerFromView:(UIView *)view
{
    if(nil == view)
    {
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
            
            [nextView release];
            [nextResponder release];
        }
        
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
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
