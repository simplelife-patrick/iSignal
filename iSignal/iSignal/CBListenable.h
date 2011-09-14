//
//  CBListenable.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-14.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBListenable <NSObject>

-(void) messageCallback:(id) message;

@end
