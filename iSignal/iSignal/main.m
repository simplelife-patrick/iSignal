//
//  main.m
//  iSignal
//
//  Created by Patrick ; on 11-8-20.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    DLog(@"Login app main entry.");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
    DLog(@"Logout app main entry.");
}