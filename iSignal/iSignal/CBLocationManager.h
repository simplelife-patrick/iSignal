//
//  CBLocationManager.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-30.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "CBModuleAbstractImpl.h"

#define MODULE_IDENTITY_LOCATION_MANAGER @"Location Module"

#define WORKMODE_STANDARD 0
#define WORKMODE_SIGNIFICANT 1

#define EVENT_AVAILABLE_TIME_DIFFERENCE 15.0

#define REGION_RADIUS_DEFAULT 100.0

#define ACCURACY_DEFAULT kCLLocationAccuracyNearestTenMeters
#define DISTANCE_DEFAULT kCLDistanceFilterNone

@interface CBLocationManager : CBModuleAbstractImpl <CLLocationManagerDelegate>

typedef NSInteger CBLocationWorkMode;

@property (nonatomic) CBLocationWorkMode workMode; 

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic) CLLocationDegrees regionRadius;

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocation *lastLocation;

+(BOOL) isLocationServiceEnabled;

+(BOOL) isRegionMonitoringAvailable;
+(BOOL) isRegionMonitoringEnabled;

-(CLLocation*) obtainLocation;

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
