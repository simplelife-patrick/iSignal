//
//  ISDummyTelephonyModule.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISDummyTelephonyModule.h"

@implementation ISDummyTelephonyModule

// Manual Codes Begin

static NSArray* CARRIER_LIST;

// Members of ISDummyTelephony
@synthesize signalStrength;
@synthesize carrier;

// Static block
+(void) initialize
{
    CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
}

// Static method
+(NSArray*) getCarrierList
{
    if(nil == CARRIER_LIST)
    {
        CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
        DLog(@"CARRIER_LIST is initialized: %@", CARRIER_LIST);
    }
    
    return CARRIER_LIST;
}

// Static method
+(NSString*) randomCarrier
{
    NSInteger min = CARRIER_CMCC;
    NSInteger max = CARRIER_CUNI;
    NSInteger arrayIndex = [CBMathUtils generateRandomNSInteger:min andMax:max];
    NSArray* carrierArray = [ISDummyTelephonyModule getCarrierList];
    NSString* carrierVal = [carrierArray objectAtIndex:arrayIndex];
    
    DLog(@"Random carrier is generated: %@", carrierVal);
    return carrierVal;
}

// Static method
+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNALSTRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNALSTRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNALSTRENGTH_HIGHEST;
    NSInteger signalVal = [CBMathUtils generateRandomNSInteger:(low - loss) andMax:high];
    
    return signalVal;
}

// Private method
-(void) refreshCarrier
{
    self.carrier = [ISDummyTelephonyModule randomCarrier];
}

// Private method
-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummyTelephonyModule randomSignalStrength];
    NSNumber *signalVal = [NSNumber numberWithInt:self.signalStrength];
    [self broadcastSignalStengthChanged:signalVal];
}

// Private method
-(void) broadcastSignalStengthChanged:(NSNumber*) signalVal
{
//    signalVal = [NSNumber numberWithInt:-150];
    NSDictionary *_dic=[[[NSDictionary alloc] initWithObjectsAndKeys:signalVal, NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED, nil] autorelease];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:self userInfo:_dic];
}

// Overrided Method of CBModuleAbstractImpl
-(void) initModule
{
    [super initModule];
    
    [self setModuleIdentity:MODULE_ID_DUMMYTEPLEPHONY];
    [self.serviceThread setName:MODULE_ID_DUMMYTEPLEPHONY];
}

// Overrided Method of CBModuleAbstractImpl
-(void) releaseModule
{
    [super releaseModule];

    [carrier release];
}

// Overrided Method of CBModuleAbstractImpl
-(void) serviceWithIndividualThread
{
    [self refreshSignalStrength];
    // Here current thread need to sleep for a small period
    NSInteger interval = [CBMathUtils generateRandomNSInteger:DUMMY_REFRESH_PERIOD_SMALL andMax:DUMMY_REFRESH_PERIOD_LONG];
    [NSThread sleepForTimeInterval:interval];    
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        [self refreshCarrier];        
    }
    
    return self;
}

// Manual Codes End

@end
