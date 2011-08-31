//
//  CBAppConfigs.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONFIG_ALARM_RING @"cfg_alarm_ring"
#define CONFIG_ALARM_VIBRATE @"cfg_alarm_vibrate"

@interface CBAppConfigs : NSObject
{

}

+(void) initConfigsIfNecessary;

+(BOOL) isRingAlarmOn;
+(void) setRingAlarmOn:(BOOL) flag;

+(BOOL) isVibrateAlarmOn;
+(void) setVibrateAlarmOn:(BOOL) flag;

@end