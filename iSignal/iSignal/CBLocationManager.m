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

// Members of CBModule protocol
@synthesize moduleIdentity;
@synthesize serviceThread;
@synthesize keepAlive;
@synthesize delegateList;

// Members of CBLocationManager
@synthesize workMode;
@synthesize regionRadius;
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize lastLocation = _lastLocation;

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

-(void) dealloc
{
    [self releaseModule];
    
    [_locationManager release];
    [_lastLocation release];
    [_currentLocation release];
    
    [super dealloc];
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
    // If it's a relatively recent event, turn off updates to save power    
    self.currentLocation = newLocation;
    self.lastLocation = oldLocation;

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

// Method of CBModule protocol
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_LOCATION_MANAGER];
    [self.serviceThread setName:MODULE_IDENTITY_LOCATION_MANAGER];
    
    [self setKeepAlive:FALSE];    
}

// Method of CBModule protocol
-(void) releaseModule
{
    [serviceThread release];
    [moduleIdentity release];
}

// Method of CBModule protocol
-(void) startService
{
    // Do not create regions if support is unavailable or disabled.
    if ( ![CBLocationManager isLocationServiceEnabled] || ![CBLocationManager isRegionMonitoringAvailable] ||
        ![CBLocationManager isRegionMonitoringEnabled] )
    {
        DLog(@"Current running environment does not support location service.");
        return;
    }    
    
    if (nil == self.serviceThread) 
    {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(processService) object:nil]; 
        self.serviceThread = thread;
        [thread release];
    }
    self.keepAlive = TRUE;
    
    [self.serviceThread start];
}

// Method of CBModule protocol
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

// Method of CBModule protocol
-(void) stopService
{
    self.keepAlive = FALSE;
}

// Method of CBModule protocol
-(void) registerDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            DLog(@"The delegate: %@ is already in registered list.", delegate);
            return;
        }
    }
    
    [self.delegateList addObject:delegate];
}

// Method of CBModule protocol
-(void) unregisterDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            [self.delegateList removeObject:delegate];
            DLog(@"The delegate: %@ has been removed out from registered list.", delegate);
            return;
        }
    }    
}

// Method of CBModule protocol
-(void) unregisterAllDelegates
{
    [self.delegateList removeAllObjects];
}

// Method of CBModule protocol
-(void) notifyAllDelegates:(id) message
{
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        [tmpDelegate messageCallback: message];
    }
}

// Method of CBModule protocol
-(void) messageCallback:(id) message
{
    
}

// Manual Coes End

@end
