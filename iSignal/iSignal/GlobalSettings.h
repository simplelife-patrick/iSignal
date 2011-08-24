//
//  GlobalSettings.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#define SIMULATOR 0
#define IPHONE 1

#if TARGET_IPHONE_SIMULATOR
    #define DEVICE SIMULATOR
#elif TARGET_OS_IPHONE
    #define DEVICE IPHONE
#endif

@interface GlobalSettings : NSObject
{
    
}

+(GlobalSettings *)singletonInstance;

@end
