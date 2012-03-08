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

@interface ISDummyTelephonyModule : CBModuleAbstractImpl

@property (nonatomic, copy) NSString *carrier;
@property (nonatomic) NSInteger signalStrength;

+(NSString*) randomCarrier;
+(NSInteger) randomSignalStrength;
+(NSArray*) getCarrierList;

@end