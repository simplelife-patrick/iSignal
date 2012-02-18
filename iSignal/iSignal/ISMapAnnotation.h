//
//  ISMapAnnotation.h
//  iSignal
//
//  Created by Patrick Deng on 12-2-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface ISMapAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

- (CLLocationCoordinate2D)coordinate;

@end