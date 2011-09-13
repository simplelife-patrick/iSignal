//
//  CBObservable.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-13.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCallbackDelegate.h"

@protocol CBObservable <NSObject>

@property NSArray *delegateList;

-(void) registerDelegate:(CBCallbackDelegate*) delegate;
-(void) unregisterDelegate:(CBCallbackDelegate*) delegate;
-(void) unregisterAllDelegates;
-(void) notifyAllDelegates;

@end
