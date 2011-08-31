//
//  CBCallbackDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBCallbackDelegate <NSObject>

-(void) messageCallback:(id) message;

@end