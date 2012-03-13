//
//  CBLocationManager.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-30.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "CBLocationManager.h"

@implementation CBLocationManager

// Manual Codes Begin

// Members of CBLocationManager
@synthesize workMode;
@synthesize regionRadius;
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize lastLocation = _lastLocation;
@synthesize geocoder = _geocoder;

// Static method
+(BOOL) isLocationServiceEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

// Static method
+(BOOL) isRegionMonitoringAvailable
{
    return [CLLocationManager regionMonitoringAvailable];
}

// Static method
+(BOOL) isRegionMonitoringEnabled
{
    return [CLLocationManager regionMonitoringEnabled];
}

-(void) initLocationManagerIfNecessary: (CLLocationAccuracy) accuracy andDistance:(CLLocationDistance) distance andWorkMode:(CBLocationWorkMode)mode
{
    [self initLocationManagerIfNecessary];
    [self setWorkMode:mode];
    [self setAccuracy:accuracy];
    [self setDistanceFilter:distance];  
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.  
        // Instance member: locationManager must be initialized before any access.
        [self initLocationManagerIfNecessary];
        
        [self setWorkMode:WORKMODE_STANDARD];
        [self setAccuracy:ACCURACY_DEFAULT];
        [self setDistanceFilter:DISTANCE_DEFAULT];
        [self setRegionRadius:REGION_RADIUS_DEFAULT];
    }
    
    return self;
}

-(CLLocation*) obtainLocation
{
    if (!_currentLocation) 
    {
        [self setCurrentLocation:_locationManager.location];
    }    
    return _currentLocation;
}

-(void) setDistanceFilter:(CLLocationDistance) distance
{
    _locationManager.distanceFilter = distance;
}

-(void) setAccuracy:(CLLocationAccuracy) accuracy
{
    _locationManager.desiredAccuracy = accuracy;
}

-(void) initLocationManagerIfNecessary
{
    if (nil == _locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    if (nil == _locationManager.delegate)
    {
        _locationManager.delegate = self;
    }
}

-(void) startStandardUpdate
{    
    [_locationManager startUpdatingLocation]; 
}

-(void) stopStandardUpdate
{  
    [_locationManager stopUpdatingLocation];
}

-(void) startSignificantChangeUpdates
{  
    [_locationManager startMonitoringSignificantLocationChanges];   
}

-(void) stopSignificantChangeUpdates
{
    [_locationManager stopMonitoringSignificantLocationChanges];
}

- (BOOL) registerRegionWithSpecificLocationAndCircularOverlay:(NSString *)identifier andLocation:(CLLocation*)location andCircleRadius:(CLLocationDegrees)radius andAccuracy:(CLLocationAccuracy)accuracy
{
    // Do not create regions if support is unavailable or disabled.
    if ( ![CBLocationManager isRegionMonitoringAvailable] ||
        ![CBLocationManager isRegionMonitoringEnabled] )
    {
        return NO;
    }
    
    if (!location || 0 >= radius || 0 >= accuracy)
    {
        return NO;
    }
    
    if (regionRadius > _locationManager.maximumRegionMonitoringDistance)
    {
        regionRadius = _locationManager.maximumRegionMonitoringDistance;
    }
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:location.coordinate
                                                               radius:radius identifier:identifier];
    [_locationManager startMonitoringForRegion:region
                                   desiredAccuracy:accuracy];
    [region release];
    
    return YES;    
}

- (BOOL) registerRegionWithCurrentLocationAndCircularOverlay:(NSString*)identifier
{
    return [self registerRegionWithSpecificLocationAndCircularOverlay:identifier andLocation:_currentLocation andCircleRadius:self.regionRadius andAccuracy:_locationManager.desiredAccuracy];
}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
    self.lastLocation = oldLocation;

//  If it's a relatively recent event, turn off updates to save power    
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < EVENT_AVAILABLE_TIME_DIFFERENCE)
//    {
//        DLog(@"New location reported: latitude %+.6f, longitude %+.6f\n",
//             newLocation.coordinate.latitude,
//             newLocation.coordinate.longitude);
//    }
}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    DLog(@"Location error message: %@", [error localizedDescription]);

    self.lastLocation = self.currentLocation;
    self.currentLocation = nil;

}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // TODO:
}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    // TODO:
}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    // TODO:
    DLog(@"Failed to monitor this region: %@ with error: %@", region, error);
}

// Overrided Method of CBModuleAbstractImpl
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_LOCATION_MANAGER];
    [self.serviceThread setName:MODULE_IDENTITY_LOCATION_MANAGER];
    
    [self setKeepAlive:FALSE];    
}

// Overrided Method of CBModuleAbstractImpl
-(void) releaseModule
{
    [super releaseModule];
    
    [_locationManager release];
    [_lastLocation release];
    [_currentLocation release];  
    [_geocoder release];
}

// Overrided Method of CBModuleAbstractImpl
-(void) startService
{
    // Do not create regions if support is unavailable or disabled.
    if ( ![CBLocationManager isLocationServiceEnabled] || ![CBLocationManager isRegionMonitoringAvailable] ||
        ![CBLocationManager isRegionMonitoringEnabled] )
    {
        DLog(@"Current running environment does not support location service.");
        return;
    }    
    
    [super startService];
}

// Overrided Method of CBModuleAbstractImpl
-(void) processService
{
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *serviceThreadPool = [[NSAutoreleasePool alloc] init];
    
    while (self.keepAlive) 
    {
        switch (self.workMode) 
        {
            case WORKMODE_STANDARD:
            {
                [self startStandardUpdate];
                
                break;
            }
            case WORKMODE_SIGNIFICANT:
            {
                [self startSignificantChangeUpdates];
                
                break;
            }
            default:
            {
                break;
            }
        }
    }
    
    switch (self.workMode) 
    {
        case WORKMODE_STANDARD:
        {
            [self stopStandardUpdate];
            
            break;
        }
        case WORKMODE_SIGNIFICANT:
        {
            [self stopSignificantChangeUpdates];
            
            break;
        }
        default:
        {
            break;
        }
    }    
    
    [serviceThreadPool release];
}

-(CLPlacemark*) reverseGeocodeLocationToPrimaryPlaceMark
{
    NSArray* placemarkArray = [self reverseGeocodeLocationToPlaceMarks];
    CLPlacemark *primaryPlacemark = (nil != placemarkArray) ? [placemarkArray objectAtIndex:0] : nil;
    return primaryPlacemark;
}

-(NSArray*) reverseGeocodeLocationToPlaceMarks
{
    __block NSArray* placemarkArray = nil;
    
    [_geocoder reverseGeocodeLocation: self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {
        placemarkArray = placemarks;
    }];
    
    return placemarkArray;
}

// Manual Codes End

@end
