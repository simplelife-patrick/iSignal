//
//  ISDummyTelephonyModule.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/NSArray.h>

#import "CBModuleAbstractImpl.h"

#define CARRIER_CMCC 0
#define CARRIER_CUNI 1

#define CELLULAR_SIGNAL_STRENGTH_HIGHEST -50
#define CELLULAR_SIGNAL_STRENGTH_LOWEST -110
#define CELLULAR_SIGNAL_STRENGTH_LOSS 20

#define REFRESH_PERIOD_SMALL 5
#define REFRESH_PERIOD_LONG 10

#define MODULE_IDENTITY_DUMMYTEPLEPHONY @"Dummy Telephony Module"

@interface ISDummyTelephonyModule : CBModuleAbstractImpl

@property (nonatomic, copy) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

@end