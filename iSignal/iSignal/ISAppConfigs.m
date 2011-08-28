//
//  ISAppConfigs.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011年 CodeAnimal. All rights reserved.
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

- (void)dealloc 
{
    [super dealloc];
}

- (id)init
{
    return nil;
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