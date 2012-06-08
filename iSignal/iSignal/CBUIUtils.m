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

+(void) showInformationAlertWindow:(id) delegate andMessage:(NSString*) message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"STR_ALERT", nil) message:message delegate:delegate cancelButtonTitle:NSLocalizedString(@"STR_OK", nil) otherButtonTitles: nil];
	[alert show];	
	[alert release];    
}

+(void) showInformationAlertWindow:(id)delegate andError:(NSError *)error
{    
    NSString *message = [error localizedDescription];
    
    [CBUIUtils showInformationAlertWindow:delegate andMessage: message];
}

+(UIAlertView*) createProgressAlertView:(NSString *) title andMessage:(NSString *) message andActivity:(BOOL) activity andDelegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title
                                                        message: message
                                                       delegate: delegate
                                              cancelButtonTitle: nil
                                              otherButtonTitles: nil];  
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    if (activity) 
    {
        x = 139.0f - 18.0f;
        y = 80.0f;
        width = 37.0f;
        height = 37.0f;
        
        if (nil == title) 
        {
            y = y - 20.0f;
        }
        
        if (nil == message)
        {
            y = y - 20.0f;
        }
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(x, y, width, height);
        [alertView addSubview:activityView];
        [activityView startAnimating];
        
        [activityView release];
    } 
    else 
    {
        x = 30.0f;
        y = 80.0f;
        width = 225.0f;
        height = 90.0f;       
        
        // TODO: Need adjust x and y values if title or message is NULL.
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [alertView addSubview:progressView];
        [progressView setProgressViewStyle: UIProgressViewStyleBar];
        
        [progressView release];
    }
    
    return alertView;
}

// Manual Codes End

@end
