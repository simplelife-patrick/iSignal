//
//  CBModule.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-31.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBListenable.h"
#import "CBObservable.h"

@protocol CBModule <NSObject>

@property BOOL isIndividualThreadNecessary;
@property BOOL keepAlive;

@property (nonatomic, copy) NSString *moduleIdentity;
@property (nonatomic, retain) NSThread *serviceThread;

-(void) initModule;
-(void) startService;
-(void) processService;
-(void) pauseService;
-(void) serviceWithIndividualThread;
-(void) serviceWithCallingThread;
-(void) stopService;
-(void) releaseModule;

@end