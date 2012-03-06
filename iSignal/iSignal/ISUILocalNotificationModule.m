//
//  ISUILocalNotificationModule.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-6.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISUILocalNotificationModule.h"

@implementation ISUILocalNotificationModule

// Overrided Method of CBModuleAbstractImpl
-(void) initModule
{    
    [super initModule];
    
    [self setModuleIdentity:MODULE_IDENTITY_UILOCALNOTIFICATION_MODULE];
    [self.serviceThread setName:MODULE_IDENTITY_UILOCALNOTIFICATION_MODULE];
}

// Overrided Method of CBModuleAbstractImpl
-(void) releaseModule
{
    [super releaseModule];
    //
}

// Overrided Method of CBModuleAbstractImpl
-(void) serviceWithCallingThread
{
    [super serviceWithCallingThread];
    
    [self listenSignalStrengthChanged];
}

// Private method
-(void) listenSignalStrengthChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSignalStrengthChanged:) name:
     NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:nil];      
}

// Private method
-(void) onSignalStrengthChanged:(NSNotification *) notification
{
    if ([ISAppConfigs isNotificationOn]) 
    {
        NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
        NSNumber *signalVal = (NSNumber*)nsValue;  
        [self performSelectorOnMainThread:@selector(popUILocalNotificationForNoSignal:) withObject:(signalVal) waitUntilDone:YES];    
    }
}

-(void) cancelAllUILocalNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

-(void) cancelUILocalNotifications:(NSString*) type
{
    NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];   
    for (int i = 0; i < [myArray count]; i++) 
    {   
        UILocalNotification *myUILocalNotification = [myArray objectAtIndex:i];
        NSString* notificationType = [[myUILocalNotification userInfo] objectForKey:NOTIFICATION_TYPE];
        if ([notificationType isEqualToString:type]) 
        {   
            [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];   
        }   
    }       
}

-(void) popUILocalNotificationForNoSignal:(NSNumber*) signalVal
{
    NSInteger intVal = [signalVal intValue];
    SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
    if (qualityGrade == QUALITY_SIGNAL_NO) 
    {
        UILocalNotification *notification=[[UILocalNotification alloc] init];   
        NSDate *now1 = [NSDate date];    
        notification.timeZone = [NSTimeZone defaultTimeZone];   
        notification.repeatInterval = NSDayCalendarUnit;   
        ++notification.applicationIconBadgeNumber;   
        notification.alertAction = NSLocalizedString(@"STR_DISPLAY", nil);   
        notification.fireDate = [now1 dateByAddingTimeInterval:10];   
        notification.alertBody = NSLocalizedString(@"STR_NOSIGNAL", nil);
        [notification setSoundName:UILocalNotificationDefaultSoundName]; 
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:   
                              NOTIFICATION_TYPE, NOTIFICATION_NOSIGNAL, nil];   
        [notification setUserInfo:dict];   
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];   
        [notification release];
    }    
}

@end
