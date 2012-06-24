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
#import "CBMathUtils.h"

@interface ISDummyTelephonyModule : CBModuleAbstractImpl
{
    NSString *carrier;
    NSInteger signalStrength;
}

@property (nonatomic, copy) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

@end