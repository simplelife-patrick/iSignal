//
//  ISAppConfigs.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISAppConfigs.h"

@implementation ISAppConfigs

// Manual Codes Begin

+(void) initConfigsIfNecessary
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
        
    id ringAlarmVal = [configs valueForKey:CONFIG_ALARM_RING];
    if(nil == ringAlarmVal)
    {
        [configs setBool:TRUE forKey:CONFIG_ALARM_RING];
    }
        
    id vibrateAlarmVal = [configs valueForKey:CONFIG_ALARM_VIBRATE];
    if (nil == vibrateAlarmVal) 
    {
        [configs setBool:TRUE forKey:CONFIG_ALARM_VIBRATE];
    }

    BOOL isLocationServiceEnabled = [CBLocationManager isLocationServiceEnabled];
    if(isLocationServiceEnabled)
    {
        id locationVal = [configs valueForKey:CONFIG_LOCATION];
        if(nil == locationVal)
        {
            [configs setBool:isLocationServiceEnabled forKey:CONFIG_LOCATION];
        }
    }
    else
    {
        [configs setBool:FALSE forKey:CONFIG_LOCATION];
    }
}

+(BOOL) isRingAlarmOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    
    return [configs boolForKey:CONFIG_ALARM_RING];
}

+(void) setRingAlarmOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    [configs setBool:flag forKey:CONFIG_ALARM_RING];
}

+(BOOL) isVibrateAlarmOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    return [configs boolForKey:CONFIG_ALARM_VIBRATE];
}

+(void) setVibrateAlarmOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    [configs setBool:flag forKey:CONFIG_ALARM_VIBRATE];
}

+(BOOL) isLocationOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    return [configs boolForKey:CONFIG_LOCATION];
}

+(void) setLocationOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    [configs setBool:flag forKey:CONFIG_LOCATION];
    
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    if(flag)
    {
        if(!appDelegate.locationModule.keepAlive)
        {
            DLog(@"Location service is going to restart as user disabled config.");
            [appDelegate.locationModule startService];            
        }
    }
    else
    {
        if(appDelegate.locationModule.keepAlive)
        {
            DLog(@"Location service is going to stop as user disabled config.");        
            [appDelegate.locationModule stopService];
        }
    }
}

- (void)dealloc 
{
    [super dealloc];
}

- (id)init
{
    return nil;
// Disable object initialization.
//    self = [super init];
//    if (self) 
//    {
//        // Initialization code here.
//    }
//    
//    return self;
}

// Manual Codes End

@end