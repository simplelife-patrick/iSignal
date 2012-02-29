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

// Members of CBModule protocol
@synthesize moduleIdentity;
@synthesize serviceThread;
@synthesize keepAlive;
@synthesize delegateList;

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
    NSArray* carrierArray = [ISDummyTelephony getCarrierList];
    NSString* carrierVal = [carrierArray objectAtIndex:arrayIndex];
    
    DLog(@"Random carrier is generated: %@", carrierVal);
    return carrierVal;
}

// Static method
+(NSInteger) randomSignalStrength
{
    NSInteger loss = CELLULAR_SIGNAL_STRENGTH_LOSS;
    NSInteger low = CELLULAR_SIGNAL_STRENGTH_LOWEST;
    NSInteger high = CELLULAR_SIGNAL_STRENGTH_HIGHEST;
    NSInteger signalVal = [CBMathUtils generateRandomNSInteger:(low - loss) andMax:high];
    
    return signalVal;
}

// Method of CBModule protocol
-(void) registerDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            DLog(@"The delegate: %@ is already in registered list.", delegate);
            return;
        }
    }
    
    [self.delegateList addObject:delegate];
}

// Method of CBModule protocol
-(void) unregisterDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            [self.delegateList removeObject:delegate];
            DLog(@"The delegate: %@ has been removed out from registered list.", delegate);
            return;
        }
    }    
}

// Method of CBModule protocol
-(void) unregisterAllDelegates
{
    [self.delegateList removeAllObjects];
}

// Method of CBModule protocol
-(void) notifyAllDelegates:(id) message
{
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        [tmpDelegate messageCallback: message];
    }
}

// Private method
-(void) refreshCarrier
{
    self.carrier = [ISDummyTelephony randomCarrier];
}

// Private method
-(void) refreshSignalStrength
{
    self.signalStrength = [ISDummyTelephony randomSignalStrength];
    // Notify listeners
    NSNumber *signalVal = [NSNumber numberWithInt:self.signalStrength];
    [self notifyAllDelegates:signalVal];    
}

// Method of CBModule protocol
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_DUMMYTEPLEPHONY];
    [self.serviceThread setName:MODULE_IDENTITY_DUMMYTEPLEPHONY];
    
    [self setKeepAlive:FALSE];
}

// Method of CBModule protocol
-(void) releaseModule
{
    [serviceThread release];
    [moduleIdentity release];
}

// Method of CBModule protocol
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

// Method of CBModule protocol
-(void) startService
{
    if (nil == self.serviceThread) 
    {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(processService) object:nil]; 
        self.serviceThread = thread;
        [thread release];
    }
    self.keepAlive = TRUE;
    
    [self.serviceThread start];
}

// Method of CBModule protocol
-(void) stopService
{
    self.keepAlive = FALSE;
}

// Method of CBModule protocol
-(void) messageCallback:(id) message
{
    
}

- (void)dealloc
{
    [self releaseModule];
    
    [delegateList release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        NSMutableArray *array = [[NSMutableArray alloc] init];
        self.delegateList = array;
        [array release];
        
        [self refreshCarrier];        
    }
    
    return self;
}

// Manual Codes End

@end
