//
//  ISDummnyTelephony.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISDummnyTelephony.h"

#import "ISMathUtils.h"

@implementation ISDummnyTelephony

// Manual Codes Begin

@synthesize callbackDelegate;
@synthesize carrierArray;

-(NSString*) randomCarrier
{
    NSInteger min = CARRIER_CMCC;
    NSInteger max = CARRIER_CUNI;
    NSInteger carrierArrayIndex = [ISMathUtils generateRandomNSInteger:min andMax:max];

    return [carrierArray objectAtIndex:carrierArrayIndex];
}

-(NSInteger) randomCellularSignalStrength
{
    NSInteger min = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger max = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    
    return [ISMathUtils generateRandomNSInteger:min andMax:max];
}

// Manual Codes End

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        carrierArray = [NSArray arrayWithObjects:@"CMCC", @"CUNI", nil];
    }
    
    return self;
}

@end
