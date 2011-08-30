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

static NSString* STR_THREAD_SIGNALMONITOR;
static NSArray* CARRIER_LIST;

@synthesize callbackDelegate;
@synthesize signalMonitorThread;
@synthesize signalStrength;
@synthesize carrier;
@synthesize keepAlive;

+(void) initialize
{
    STR_THREAD_SIGNALMONITOR = @"Thread_SignalMonitor";
    CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
}

+(NSArray*) getCarrierList
{
    if(nil == CARRIER_LIST)
    {
        CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
        DLog(@"CARRIER_LIST initialized: %@", CARRIER_LIST);
    }
    
    return CARRIER_LIST;
}

+(NSString*) randomCarrier
{
    NSInteger min = CARRIER_CMCC;
    NSInteger max = CARRIER_CUNI;
    NSInteger arrayIndex = [ISMathUtils generateRandomNSInteger:min andMax:max];
    NSArray *carrierArray = [ISDummyTelephony getCarrierList];
    NSString* carrierVal = [carrierArray objectAtIndex:arrayIndex];
    
    DLog(@"Dummy telephony generated random carrier: %@", carrierVal);
    return carrierVal;
}

+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    NSInteger signalVal = [ISMathUtils generateRandomNSInteger:(low - loss) andMax:high];
    
    DLog(@"Dummy telephony generated random signal srength: %d", signalVal);
    return signalVal;
}

-(void) refreshCarrier
{
    self.carrier = [ISDummyTelephony randomCarrier];
    DLog(@"Dummy telephony's carrier is set to: %@", self.carrier);
}

-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummyTelephony randomSignalStrength];
    DLog(@"Dummy telephony's signal strength is set to: %d", self.signalStrength);
    // Callback delegate to notify listener
    if(nil != self.callbackDelegate)
    {
        NSNumber *signalVal = [NSNumber numberWithInt:self.signalStrength];
        DLog(@"Callback by signal strength changed: %@", signalVal);
        [self.callbackDelegate messageCallback:signalVal];
        [signalVal release];
    }
}

-(void) signalMonitorThreadRun
{
    DLog(@"Dummy telephony's signal monitor thread started to run.");
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *signalMonitorThreadPool = [[NSAutoreleasePool alloc] init];
    while (self.keepAlive && (nil != self.callbackDelegate)) 
    {
        [self refreshSignalStrength];
        // Here current thread need to sleep for a small period
        NSInteger interval = [ISMathUtils generateRandomNSInteger:REFRESH_PERIOD_SMALL andMax:REFRESH_PERIOD_LONG];
        [NSThread sleepForTimeInterval:interval];
    }
    [signalMonitorThreadPool release];
    DLog(@"Dummy telephony's signal monitor thread stopped to run.");
}

-(void) startToService
{
    DLog(@"Dummy telephony service is running.");
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
    DLog(@"Dummy telephony service stopped.");
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
