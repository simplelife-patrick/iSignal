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
        
    id ringAlarmVal = [configs valueForKey:APPCONFIG_ALARM_RING];
    if(nil == ringAlarmVal)
    {
        [configs setBool:TRUE forKey:APPCONFIG_ALARM_RING];
    }
        
    id vibrateAlarmVal = [configs valueForKey:APPCONFIG_ALARM_VIBRATE];
    if (nil == vibrateAlarmVal) 
    {
        [configs setBool:TRUE forKey:APPCONFIG_ALARM_VIBRATE];
    }

    BOOL isLocationServiceEnabled = [CBLocationManager isLocationServiceEnabled];
    if(isLocationServiceEnabled)
    {
        id locationVal = [configs valueForKey:APPCONFIG_LOCATION];
        if(nil == locationVal)
        {
            [configs setBool:isLocationServiceEnabled forKey:APPCONFIG_LOCATION];
        }
    }
    else
    {
        [configs setBool:FALSE forKey:APPCONFIG_LOCATION];
    }
    
    [configs setBool:TRUE forKey:APPCONFIG_NOTIFICATION];
}

+(BOOL) isRingAlarmOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    
    return [configs boolForKey:APPCONFIG_ALARM_RING];
}

+(void) setRingAlarmOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    [configs setBool:flag forKey:APPCONFIG_ALARM_RING];
}

+(BOOL) isVibrateAlarmOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    return [configs boolForKey:APPCONFIG_ALARM_VIBRATE];
}

+(void) setVibrateAlarmOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    [configs setBool:flag forKey:APPCONFIG_ALARM_VIBRATE];
}

+(BOOL) isLocationOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    return [configs boolForKey:APPCONFIG_LOCATION];
}

+(void) setLocationOn:(BOOL)flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];
    [configs setBool:flag forKey:APPCONFIG_LOCATION];
    
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

+(BOOL) isNotificationOn
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    return [configs boolForKey:APPCONFIG_NOTIFICATION];    
}

+(void) setNotificationOn:(BOOL) flag
{
    NSUserDefaults *configs = [NSUserDefaults standardUserDefaults];    
    [configs setBool:flag forKey:APPCONFIG_NOTIFICATION];   
}

// Manual Codes End

@end