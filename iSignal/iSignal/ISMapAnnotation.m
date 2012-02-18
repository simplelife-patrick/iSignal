//
//  ISMapAnnotation.m
//  iSignal
//
//  Created by Patrick Deng on 12-2-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISMapAnnotation.h"

@implementation ISMapAnnotation

@synthesize image;
@synthesize latitude;
@synthesize longitude;


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [self.latitude doubleValue];
    theCoordinate.longitude = [self.longitude doubleValue];
    return theCoordinate; 
}

- (void)dealloc
{
    [self.image release];
    
    [super dealloc];
}

@end
