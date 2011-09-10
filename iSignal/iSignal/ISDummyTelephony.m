//
//  ISDummnyTelephony.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISDummyTelephony.h"

#import "CBMathUtils.h"

@implementation ISDummyTelephony

// Manual Codes Begin

static NSArray* CARRIER_LIST;

// Members of CBModule protocol.

@synthesize moduleIdentity;
@synthesize serviceThread;
@synthesize keepAlive;
@synthesize callbackDelegate;

// Members of ISDummyTelephony
@synthesize signalStrength;
@synthesize carrier;

+(void) initialize
{
    CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
}

+(NSArray*) getCarrierList
{
    if(nil == CARRIER_LIST)
    {
        CARRIER_LIST = [NSArray arrayWithObjects:NSLocalizedString(@"STR_CMCC",nil), NSLocalizedString(@"STR_CUNI", nil), nil];
        DLog(@"CARRIER_LIST is initialized: %@", CARRIER_LIST);
    }
    
    return CARRIER_LIST;
}

+(NSString*) randomCarrier
{
    NSInteger min = CARRIER_CMCC;
    NSInteger max = CARRIER_CUNI;
    NSInteger arrayIndex = [CBMathUtils generateRandomNSInteger:min andMax:max];
    NSArray *carrierArray = [ISDummyTelephony getCarrierList];
    NSString* carrierVal = [carrierArray objectAtIndex:arrayIndex];
    
    DLog(@"Random carrier is generated: %@", carrierVal);
    return carrierVal;
}

+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    NSInteger signalVal = [CBMathUtils generateRandomNSInteger:(low - loss) andMax:high];
    
    DLog(@"Random signal srength is generated: %d", signalVal);
    return signalVal;
}

-(void) refreshCarrier
{
    self.carrier = [ISDummyTelephony randomCarrier];
}

-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummyTelephony randomSignalStrength];
    DLog(@"Received new signal strength value: %d", self.signalStrength);
    // Callback delegate to notify listener
    if(nil != self.callbackDelegate)
    {
        NSNumber *signalVal = [NSNumber numberWithInt:self.signalStrength];
        DLog(@"Callback by signal strength changed: %@", signalVal);
        [self.callbackDelegate messageCallback:signalVal];
        [signalVal release];
    }
}

-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_DUMMYTEPLEPHONY];
    [self.serviceThread setName:MODULE_IDENTITY_DUMMYTEPLEPHONY];
    
    [self setKeepAlive:FALSE];    
}

-(void) releaseModule
{
    [self.serviceThread release];
    [self.moduleIdentity release];
}

-(void) processService
{
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *serviceThreadPool = [[NSAutoreleasePool alloc] init];
    while (self.keepAlive) 
    {
        [self refreshSignalStrength];
        // Here current thread need to sleep for a small period
        NSInteger interval = [CBMathUtils generateRandomNSInteger:REFRESH_PERIOD_SMALL andMax:REFRESH_PERIOD_LONG];
        [NSThread sleepForTimeInterval:interval];
    }
    [serviceThreadPool release];
}

-(void) startService
{
    if (nil == self.serviceThread) 
    {
        self.serviceThread = [[NSThread alloc] initWithTarget:self selector:@selector(processService) object:nil]; 
    }
    self.keepAlive = TRUE;
    
    [self.serviceThread start];
}

-(void) stopService
{
    self.keepAlive = FALSE;
}

- (void)dealloc
{
    [self releaseModule];
    
    [self.callbackDelegate release];
    [self.carrier release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        [self initModule];
        
        [self refreshCarrier];        
    }
    
    return self;
}

// Manual Codes End

@end
