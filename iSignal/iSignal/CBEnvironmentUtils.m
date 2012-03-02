//
//  CBEnvironmentUtils.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "CBEnvironmentUtils.h"

@interface CBEnvironmentUtils (privateMethods)

-(void)realRelease;

@end


@implementation CBEnvironmentUtils

// Manual Codes Begin
+(BOOL) isBackgroundRunningEnabled
{
    UIDevice* device = [UIDevice currentDevice];  
    BOOL backgroundSupported = NO;  
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])  
    {
        backgroundSupported = device.multitaskingSupported;        
    }
    return backgroundSupported;
}

+(NSURL*) applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// Manual Codes End

@end
