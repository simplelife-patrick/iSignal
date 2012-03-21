//
//  ISAppConfigs.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

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

+(BOOL) isTrackingRealSignal;
+(void) setTrackingRealSignal:(BOOL) flag;

@end