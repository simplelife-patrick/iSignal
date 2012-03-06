//
//  ISUILocalNotificationModule.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-6.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBModuleAbstractImpl.h"

#define MODULE_IDENTITY_UILOCALNOTIFICATION_MODULE @"UI LocalNotification Module"

#define NOTIFICATION_TYPE @"NotificationType"

#define NOTIFICATION_NOSIGNAL @"NoSignal"

@interface ISUILocalNotificationModule : CBModuleAbstractImpl

-(void) popUILocalNotificationForNoSignal:(NSNumber*) signalVal;

-(void) cancelUILocalNotifications:(NSString*) type;

-(void) cancelAllUILocalNotifications;

@end
