//
//  ISCallbackDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-23.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISCallbackDelegate <NSObject>

-(void) messageCallback:(id) message;

@end
