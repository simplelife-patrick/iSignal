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

#define CARRIER_CMCC 0;
#define CARRIER_CUNI 1;

#define CELLULAR_SIGNAL_STRENGTH_HIGHEST -50;
#define CELLULAR_SIGNAL_STRENGTH_LOWEST -110;
#define CELLULAR_SIGNAL_STRENGTH_LOSS 20;

static NSString* STR_THREAD_SIGNALMONITOR = @"Thread_SignalMonitor";

@interface ISDummnyTelephony : NSObject <ISCallbackDelegate>
{
    id<ISCallbackDelegate> callbackDelegate;
    NSThread *signalMonitor;
    NSInteger signalStrength;
    NSString *carrier;
}

@property (nonatomic, retain) id<ISCallbackDelegate> callbackDelegate; 
@property (nonatomic, retain) NSThread *signalMonitor;
@property (nonatomic, retain) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

-(void) startToService;
-(void) stopFromService;

@end