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

static CBEnvironmentUtils* instance = nil;

+(CBEnvironmentUtils *)singletonInstance
{
    @synchronized(self)
    {
        if (nil == instance) 
        {
            instance = [[self alloc] init];
            DLog(@"Singleton instance created: %@", instance);
        }
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    DLog(@"Singleton instance created or returned: %@", instance);
    @synchronized(self) 
    {
        if (nil == instance) 
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    DLog(@"Singleton instance returned: %@", instance);
    return self;
}

- (id)retain
{
    DLog(@"Singleton instance returned: %@", instance);
    return self;
}

- (unsigned)retainCount
{
    DLog(@"Singleton instance's retainCount is always 1");
    return 1;
}

- (oneway void)release
{
    DLog(@"Singleton instance release nothing here.");
}

- (id)autorelease
{
    DLog(@"Singleton instance returned: %@", instance);
    return self;
}

-(void)realRelease
{
    DLog(@"Singleton instance real release itself here: %@", instance);    
    [super release];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

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

// Manual Codes End

@end
