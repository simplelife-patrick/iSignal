//
//  CBModule.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-31.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCallbackDelegate.h"

@protocol CBModule <NSObject>

@property BOOL keepAlive;

@property (nonatomic, retain) id<CBCallbackDelegate> callbackDelegate;

@property (nonatomic, retain) NSString *moduleIdentity;
@property (nonatomic, retain) NSThread *serviceThread;

-(void) initModule;
-(void) startService;
-(void) processService;
-(void) stopService;
-(void) releaseModule;

@end