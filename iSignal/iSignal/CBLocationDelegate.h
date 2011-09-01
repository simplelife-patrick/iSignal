//
//  CBLocationDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-30.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "CBModule.h"

#define WORKMODE_STANDARD 0
#define WORKMODE_SIGNIFICANT 1

#define EVENT_AVAILABLE_TIME_DIFFERENCE 15.0

#define REGION_RADIUS_DEFAULT 100.0

#define ACCURACY_DEFAULT kCLLocationAccuracyBest
#define DISTANCE_DEFAULT 100

@interface CBLocationDelegate : NSObject <CLLocationManagerDelegate, MKReverseGeocoderDelegate, CBModule>

typedef NSInteger CBLocationWorkMode;

@property (nonatomic) CBLocationWorkMode workMode; 

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) CLLocation *lastLocation;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic) CLLocationDegrees regionRadius;

@property (nonatomic, retain) MKReverseGeocoder *reverseGeocoder;

+(BOOL) isLocationServiceEnabled;

+(BOOL) isRegionMonitoringAvailable;
+(BOOL) isRegionMonitoringEnabled;

-(void) setDistanceFilter:(CLLocationDistance) distance;
-(void) setAccuracy:(CLLocationAccuracy) accuracy;

-(void) initLocationManagerIfNecessary;
-(void) initLocationManagerIfNecessary:(CLLocationAccuracy) accuracy andDistance:(CLLocationDistance) distance andWorkMode:(CBLocationWorkMode) mode;

-(void) startStandardUpdate;
-(void) stopStandardUpdate;

-(void) startSignificantChangeUpdates;
-(void) stopSignificantChangeUpdates;

-(BOOL) registerRegionWithSpecificLocationAndCircularOverlay:(NSString*)identifier andLocation:(CLLocation*) location andCircleRadius:(CLLocationDegrees) radius andAccuracy:(CLLocationAccuracy) accuracy;
-(BOOL) registerRegionWithCurrentLocationAndCircularOverlay:(NSString*)identifier;

@end
