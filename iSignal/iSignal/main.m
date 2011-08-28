//
//  main.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-20.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISTelephonyUtils.h"

int main(int argc, char *argv[])
{
    DLog(@"Login app main entry.");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
    DLog(@"Logout app main entry.");
    [ISTelephonyUtils evaluateSignalQuality:98];
}