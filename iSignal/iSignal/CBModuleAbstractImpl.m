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
@synthesize isIndividualThreadNecessary;
@synthesize keepAlive;

@synthesize moduleIdentity;
@synthesize serviceThread;

- (id)initWithIsIndividualThreadNecessary:(BOOL) necessary
{
    self.isIndividualThreadNecessary = necessary;
    
    return [self init];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
    }
    
    return self;
}

- (void)dealloc
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
    DLog(@"Module:%@ is started.", self.moduleIdentity);
    self.keepAlive = TRUE;
    
    if (self.isIndividualThreadNecessary) 
    {
        if (nil == self.serviceThread) 
        {
            [self.serviceThread release];
        }    
        
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(processService) object:nil]; 
        self.serviceThread = thread;
        [thread release];        
        
        [self.serviceThread start];
    }
    else
    {
        [self processService];
    }
}

// Method of CBModule protocol
-(void) pauseService
{
    
}

// Method of CBModule protocol
-(void) serviceWithIndividualThread
{
    DLog(@"Module:%@ is in service with individual thread.", self.moduleIdentity);
    // Insert business logic here
    // ***** WARNING: Codes should release CPU control in intermittently! *****
}

// Method of CBModule protocol
-(void) serviceWithCallingThread
{
    DLog(@"Module:%@ is in service with calling thread.", self.moduleIdentity);
    // Insert business logic here
}

// Method of CBModule protocol
-(void) processService
{
    if(self.isIndividualThreadNecessary)
    {
        // Every NSThread need an individual NSAutoreleasePool to manage memory.
        NSAutoreleasePool *serviceThreadPool = [[NSAutoreleasePool alloc] init];
        
        while (self.keepAlive) 
        {
            [self serviceWithIndividualThread];
        } 
        
        [serviceThreadPool release];        
    }
    else
    {
        [self serviceWithCallingThread];
    }
}

// Method of CBModule protocol
-(void) stopService
{
    self.keepAlive = FALSE;
    DLog(@"Module:%@ is stopped.", self.moduleIdentity);
}

// Manual Codes End

@end
