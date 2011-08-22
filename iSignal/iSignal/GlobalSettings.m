//
//  GlobalSettings.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "GlobalSettings.h"

@implementation GlobalSettings

static GlobalSettings* instance = nil;

+(GlobalSettings *)singletonInstance
{
    if (nil == instance) 
    {
        instance = [[self alloc] init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

@end
