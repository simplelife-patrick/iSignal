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
@synthesize signalMonitor;
@synthesize signalStrength;
@synthesize carrier;

+(NSArray*) getCarrierList
{
    NSArray* carrierArray = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
    return carrierArray;
}

+(NSString*) randomCarrier
{
    NSInteger min = CARRIER_CMCC;
    NSInteger max = CARRIER_CUNI;
    NSInteger arrayIndex = [ISMathUtils generateRandomNSInteger:min andMax:max];
    NSArray* carrierArray = [ISDummnyTelephony getCarrierList];
    return [carrierArray objectAtIndex:arrayIndex];
}

+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    
    return [ISMathUtils generateRandomNSInteger:(low - loss) andMax:high];
}

-(void) startToService
{
    
}

-(void) stopFromService
{
    
}

-(void) refreshCarrier
{
    self.carrier = [ISDummnyTelephony randomCarrier];
}

-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummnyTelephony randomSignalStrength];
    // Callback delegate to notify listener
    [self.callbackDelegate messageCallback:[NSNumber numberWithInt:self.signalStrength]];
}

-(void) signalMonitorRun
{
    while (TRUE) 
    {
        [self refreshSignalStrength];
        // Here current thread need to sleep for a small period
        
    }
}

-(void) initSignalMonitor
{
    signalMonitor = [[NSThread alloc] initWithTarget:self selector:@selector(updateSignalStrength) object:nil];
    extern NSString* STR_THREAD_SIGNALMONITOR;
    [signalMonitor setName:STR_THREAD_SIGNALMONITOR];
//    [signalMonitor start];
}

-(void) messageCallback:(id)message
{
    
}

- (void)dealloc
{
    [signalMonitor release];
    [callbackDelegate release];
    [carrier release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        [self initSignalMonitor];
    }
    
    return self;
}

// Manual Codes End

@end
