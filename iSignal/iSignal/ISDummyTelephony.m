//
//  ISDummnyTelephony.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISDummyTelephony.h"

#import "ISMathUtils.h"

@implementation ISDummyTelephony

// Manual Codes Begin

@synthesize callbackDelegate;
@synthesize signalMonitorThread;
@synthesize signalStrength;
@synthesize carrier;
@synthesize keepAlive;

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
    NSArray* carrierArray = [ISDummyTelephony getCarrierList];
    return [carrierArray objectAtIndex:arrayIndex];
}

+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    
    return [ISMathUtils generateRandomNSInteger:(low - loss) andMax:high];
}

-(void) refreshCarrier
{
    self.carrier = [ISDummyTelephony randomCarrier];
}

-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummyTelephony randomSignalStrength];
    // Callback delegate to notify listener
    if(nil != self.callbackDelegate)
    {
        NSNumber *signalVal = [NSNumber numberWithInt:self.signalStrength];
        [self.callbackDelegate messageCallback:signalVal];
        [signalVal release];
    }
}

-(void) signalMonitorThreadRun
{
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *signalMonitorThreadPool = [[NSAutoreleasePool alloc] init];
    while (self.keepAlive && (nil != self.callbackDelegate)) 
    {
        [self refreshSignalStrength];
        // Here current thread need to sleep for a small period
        NSInteger interval = [ISMathUtils generateRandomNSInteger:1 andMax:10];
        [NSThread sleepForTimeInterval:interval];
    }
    [signalMonitorThreadPool release];
}

-(void) startToService
{
    if (nil == self.signalMonitorThread) 
    {
        self.signalMonitorThread = [[NSThread alloc] initWithTarget:self selector:@selector(signalMonitorThreadRun) object:nil];
        extern NSString* STR_THREAD_SIGNALMONITOR;
        [signalMonitorThread setName:STR_THREAD_SIGNALMONITOR];      
    }
    self.keepAlive = TRUE;
    
    [signalMonitorThread start];
}

-(void) stopFromService
{
    self.keepAlive = FALSE;
}

- (void)dealloc
{
    [signalMonitorThread release];
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
        [self refreshCarrier];
    }
    
    return self;
}

// Manual Codes End

@end
