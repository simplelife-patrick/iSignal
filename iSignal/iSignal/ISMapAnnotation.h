//
//  ISMapAnnotation.h
//  iSignal
//
//  Created by Patrick Deng on 12-2-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "SignalRecord.h"

static NSString* ISMapAnnotationIdentifier = @"ISMapAnnotationIdentifier";

@interface ISMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) SignalRecord *signalRecord;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (CLLocationCoordinate2D)coordinate;

@end