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
    
    [self setModuleIdentity:MODULE_ID_LOCALNOTIFICATION];
    [self.serviceThread setName:MODULE_ID_LOCALNOTIFICATION];
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
    NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
    NSNumber *signalVal = (NSNumber*)nsValue;  
    [self performSelectorOnMainThread:@selector(popUILocalNotificationForNoSignal:) withObject:(signalVal) waitUntilDone:YES];    
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

-(void) popUILocalNotificationForAppEntersBackground
{
    if ([ISAppConfigs isNotificationOn]) 
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        NSDate *now = [NSDate date];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        NSArray *stringArray = [NSArray arrayWithObjects:NSLocalizedString(@"STR_APPENTERSBACKGROUND", nil), [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:now], nil];
        NSString *bodyString = [stringArray componentsJoinedByString:@" "];        
        notification.alertBody = bodyString;
        [notification setSoundName:UILocalNotificationDefaultSoundName];         
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:   
                              NOTIFICATION_APPENTERSBACKGROUND, NOTIFICATION_TYPE, nil];   
        [notification setUserInfo:dict];   
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];   
        [notification release];        
    }
}

-(void) popUILocalNotificationForAppIsTerminated
{
    if ([ISAppConfigs isNotificationOn]) 
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init];   
        NSDate *now = [NSDate date];    
        notification.timeZone = [NSTimeZone defaultTimeZone];   
        NSArray *stringArray = [NSArray arrayWithObjects:NSLocalizedString(@"STR_APPISTERMINATED", nil), [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:now], nil];
        NSString *bodyString = [stringArray componentsJoinedByString:@" "];        
        notification.alertBody = bodyString;
        [notification setSoundName:UILocalNotificationDefaultSoundName];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:   
                              NOTIFICATION_APPISTERMINATED, NOTIFICATION_TYPE, nil];   
        [notification setUserInfo:dict];   
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];   
        [notification release];        
    }
}

-(void) popUILocalNotificationForNoSignal:(NSNumber*) signalVal
{
    if ([ISAppConfigs isNotificationOn])
    {
        NSInteger intVal = [signalVal intValue];
        SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
        if (qualityGrade == QUALITY_SIGNAL_NO) 
        {
            UILocalNotification *notification=[[UILocalNotification alloc] init];   
            NSDate *now = [NSDate date];    
            notification.timeZone = [NSTimeZone defaultTimeZone];   
            notification.repeatInterval = NSDayCalendarUnit;   

            UIApplication *application = [UIApplication sharedApplication];
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1;   
           
            notification.alertAction = NSLocalizedString(@"STR_DISPLAY", nil);   
            notification.fireDate = [now dateByAddingTimeInterval:0];  
            
            NSArray *stringArray = [NSArray arrayWithObjects:NSLocalizedString(@"STR_NOSIGNAL", nil), [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:now], nil];
            NSString *bodyString = [stringArray componentsJoinedByString:@" "];
            
            notification.alertBody = bodyString;
            [notification setSoundName:UILocalNotificationDefaultSoundName]; 
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:   
                                  NOTIFICATION_NOSIGNAL, NOTIFICATION_TYPE, nil];   
            [notification setUserInfo:dict];   
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];   
   
            [notification release];
        }          
    }
}

@end
