//
//  ISDummnyTelephony.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/NSArray.h>

#import "ISCallbackDelegate.h"

#define CARRIER_CMCC 0
#define CARRIER_CUNI 1

#define CELLULAR_SIGNAL_STRENGTH_HIGHEST -50
#define CELLULAR_SIGNAL_STRENGTH_LOWEST -110
#define CELLULAR_SIGNAL_STRENGTH_LOSS 20

#define REFRESH_PERIOD_SMALL 0
#define REFRESH_PERIOD_LONG 1

static NSString* STR_THREAD_SIGNALMONITOR = @"Thread_SignalMonitor";
static NSArray* CARRIER_LIST = nil;

@interface ISDummyTelephony : NSObject
{
    id<ISCallbackDelegate> callbackDelegate;
    NSThread *signalMonitorThread;
    NSInteger signalStrength;
    NSString *carrier;
    BOOL keepAlive;
}

@property (nonatomic, retain) id<ISCallbackDelegate> callbackDelegate; 
@property (nonatomic, retain) NSThread *signalMonitorThread;
@property (nonatomic, retain) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;
@property (nonatomic) BOOL keepAlive;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

-(void) startToService;
-(void) stopFromService;

@end