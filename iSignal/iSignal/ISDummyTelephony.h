//
//  ISDummnyTelephony.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/NSArray.h>

#import "CBCallbackDelegate.h"

#import "CBModule.h"

#define CARRIER_CMCC 0
#define CARRIER_CUNI 1

#define CELLULAR_SIGNAL_STRENGTH_HIGHEST -50
#define CELLULAR_SIGNAL_STRENGTH_LOWEST -110
#define CELLULAR_SIGNAL_STRENGTH_LOSS 20

#define REFRESH_PERIOD_SMALL 1
#define REFRESH_PERIOD_LONG 5

#define MODULE_IDENTITY_DUMMYTEPLEPHONY @"DummyTelephony"

@interface ISDummyTelephony : NSObject <CBModule>
{
    id<CBCallbackDelegate> callbackDelegate;
    NSInteger signalStrength;
    NSString *carrier;
    BOOL keepAlive;
}

@property (nonatomic, retain) id<CBCallbackDelegate> callbackDelegate;
@property (nonatomic, retain) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;
@property (nonatomic) BOOL keepAlive;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

@end