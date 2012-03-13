//
//  ISUILocalNotificationModule.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-6.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBModuleAbstractImpl.h"

@interface ISUILocalNotificationModule : CBModuleAbstractImpl

-(void) popUILocalNotificationForNoSignal:(NSNumber*) signalVal;

-(void) popUILocalNotificationForAppIsTerminated;

-(void) popUILocalNotificationForAppEntersBackground;

-(void) cancelUILocalNotifications:(NSString*) type;

-(void) cancelAllUILocalNotifications;


@end
