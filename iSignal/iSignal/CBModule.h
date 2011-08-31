//
//  CBModule.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-31.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBModule <NSObject>

-(void) startToService;
-(void) stopFromService;

@end
