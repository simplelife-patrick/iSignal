//
//  ISAppConfigs.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONFIG_ALARM_RING @"cfg_alarm_ring"
#define CONFIG_ALARM_VIBRATE @"cfg_alarm_vibrate"
#define CONFIG_LOCATION @"cfg_location"
#define CONFIG_NOTIFICATION @"cfg_notification"

#define MODULE_IDENTITY_APP_CONFIGS @"App Configugration Module"

@interface ISAppConfigs : NSObject

+(void) initConfigsIfNecessary;

+(BOOL) isRingAlarmOn;
+(void) setRingAlarmOn:(BOOL) flag;

+(BOOL) isVibrateAlarmOn;
+(void) setVibrateAlarmOn:(BOOL) flag;

+(BOOL) isLocationOn;
+(void) setLocationOn:(BOOL) flag;

+(BOOL) isNotificationOn;
+(void) setNotificationOn:(BOOL) flag;

@end