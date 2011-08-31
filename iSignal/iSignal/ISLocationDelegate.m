//
//  ISLocationDelegate.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-30.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISLocationDelegate.h"

@implementation ISLocationDelegate

// Manual Codes Begin

@synthesize locationManager;

@synthesize lastLocation;
@synthesize currentLocation;
@synthesize regionRadius;

+(BOOL) isLocationServiceEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

+(BOOL) isRegionMonitoringAvailable
{
    return [CLLocationManager regionMonitoringAvailable];
}

+(BOOL) isRegionMonitoringEnabled
{
    return [CLLocationManager regionMonitoringEnabled];
}

-(void) setDistanceFilter:(CLLocationDistance) distance
{
    self.locationManager.distanceFilter = distance;
}

-(void) setAccuracy:(CLLocationAccuracy) accuracy
{
    self.locationManager.desiredAccuracy = accuracy;
}

-(void) initLocationManagerIfNecessary
{
    if (nil == locationManager)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    if (nil == locationManager.delegate)
    {
        locationManager.delegate = self;
    }
}

-(void) initLocationManagerIfNecessary: (CLLocationAccuracy) accuracy andDistance:(CLLocationDistance) distance
{
    [self initLocationManagerIfNecessary];

    [self setAccuracy:accuracy];
    [self setDistanceFilter:distance];
}

-(void) startStandardUpdate
{
    [self initLocationManagerIfNecessary];
    
    [self.locationManager startUpdatingLocation];    
}

- (void)startSignificantChangeUpdates
{
    [self initLocationManagerIfNecessary];
    
    [self.locationManager startMonitoringSignificantLocationChanges];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < EVENT_AVAILABLE_TIME_DIFFERENCE)
    {
        self.lastLocation = self.currentLocation;
        self.currentLocation = newLocation;
        
        DLog(@"New location reported: latitude %+.6f, longitude %+.6f\n",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
    }
    // else skip the event and process the next one.
}

- (BOOL)registerRegionWithCurrentLocationAndCircularOverlay:(NSString*)identifier
{
    // Do not create regions if support is unavailable or disabled.
    if ( ![ISLocationDelegate isRegionMonitoringAvailable] ||
        ![ISLocationDelegate isRegionMonitoringEnabled] )
    {
        return NO;
    }
    
    if (regionRadius > self.locationManager.maximumRegionMonitoringDistance)
    {
        regionRadius = self.locationManager.maximumRegionMonitoringDistance;
    }
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:self.currentLocation.coordinate
                                                               radius:self.regionRadius identifier:identifier];
    [self.locationManager startMonitoringForRegion:region
                              desiredAccuracy:self.locationManager.desiredAccuracy];
    [region release];
    
    return YES;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // TODO:
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    // TODO:
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        self.regionRadius = REGION_RADIUS_DEFAULT;
    }
    
    return self;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    // TODO:
    DLog(@"Failed to monitor this region: %@ with error: %@", region, error);
}

-(void) dealloc
{
    [self.locationManager release];

    [super dealloc];
}

// Manual Coes End

@end
