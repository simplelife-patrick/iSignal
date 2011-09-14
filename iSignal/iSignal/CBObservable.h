//
//  CBObservable.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-13.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBListenable.h"

@protocol CBObservable <NSObject>

@property (nonatomic, retain) NSMutableArray *delegateList;

-(void) registerDelegate:(id<CBListenable>) delegate;
-(void) unregisterDelegate:(id<CBListenable>) delegate;
-(void) unregisterAllDelegates;
-(void) notifyAllDelegates:(id) message;

@end
