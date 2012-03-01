//
//  CBModuleAbstractImpl.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-1.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBModuleAbstractImpl.h"

@implementation CBModuleAbstractImpl

// Manual Codes Begin

// Members of CBModule protocol
@synthesize moduleIdentity;
@synthesize serviceThread;
@synthesize keepAlive;
@synthesize delegateList;

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.  
    }
    
    return self;
}

-(void) dealloc
{
    [self releaseModule];
    
    [super dealloc];
}

// Method of CBModule protocol
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_ABSTRACT_IMPL];
    [self.serviceThread setName:MODULE_IDENTITY_ABSTRACT_IMPL];
    
    [self setKeepAlive:FALSE];    
}

// Method of CBModule protocol
-(void) releaseModule
{
    [serviceThread release];
    [moduleIdentity release];
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
-(void) processService
{
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *serviceThreadPool = [[NSAutoreleasePool alloc] init];
    
    while (self.keepAlive) 
    {
        // Insert business logic here
    } 
    
    [serviceThreadPool release];
}

// Method of CBModule protocol
-(void) stopService
{
    self.keepAlive = FALSE;
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

// Method of CBModule protocol
-(void) messageCallback:(id) message
{
    
}

// Manual Codes End

@end
