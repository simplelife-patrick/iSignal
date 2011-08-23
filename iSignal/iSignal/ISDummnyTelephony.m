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
    NSInteger arrayIndex = [ISMathUtils generateRandomNSInteger:min andMax:max];

    return [carrierArray objectAtIndex:arrayIndex];
}

-(NSInteger) randomCellularSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    
    return [ISMathUtils generateRandomNSInteger:(low - loss) andMax:high];
}

-(void) initCarrierArray
{
    carrierArray = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
}

-(void) messageCallback:(id)message
{
    
}

// Manual Codes End

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        [self initCarrierArray];
    }
    
    return self;
}

@end
