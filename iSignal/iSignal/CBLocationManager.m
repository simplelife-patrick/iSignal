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
@synthesize locationManager;
@synthesize lastLocation;
@synthesize currentLocation;
@synthesize regionRadius;

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

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.        
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
    
    [self.locationManager release];

    [self.lastLocation release];
    [self.currentLocation release];
    
    [super dealloc];
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

-(void) initLocationManagerIfNecessary: (CLLocationAccuracy) accuracy andDistance:(CLLocationDistance) distance andWorkMode:(CBLocationWorkMode)mode
{
    [self initLocationManagerIfNecessary];
    [self setWorkMode:mode];
    [self setAccuracy:accuracy];
    [self setDistanceFilter:distance];
}

-(void) startStandardUpdate
{
    [self initLocationManagerIfNecessary];
    
    [self.locationManager startUpdatingLocation]; 
}

-(void) stopStandardUpdate
{
    [self.locationManager stopUpdatingLocation];
}

-(void) startSignificantChangeUpdates
{
    [self initLocationManagerIfNecessary];
    
    [self.locationManager startMonitoringSignificantLocationChanges];
}

-(void) stopSignificantChangeUpdates
{
    [self.locationManager stopMonitoringSignificantLocationChanges];
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
    
    if (regionRadius > self.locationManager.maximumRegionMonitoringDistance)
    {
        regionRadius = self.locationManager.maximumRegionMonitoringDistance;
    }
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:location.coordinate
                                                               radius:radius identifier:identifier];
    [self.locationManager startMonitoringForRegion:region
                                   desiredAccuracy:accuracy];
    [region release];
    
    return YES;    
}

- (BOOL) registerRegionWithCurrentLocationAndCircularOverlay:(NSString*)identifier
{
    return [self registerRegionWithSpecificLocationAndCircularOverlay:identifier andLocation:self.currentLocation andCircleRadius:self.regionRadius andAccuracy:self.locationManager.desiredAccuracy];
}

// Method of CLLocationManagerDelegate protocol
- (void) locationManager:(CLLocationManager *)manager
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
    [self.serviceThread release];
    [self.moduleIdentity release];
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
        self.serviceThread = [[NSThread alloc] initWithTarget:self selector:@selector(processService) object:nil]; 
    }
    self.keepAlive = TRUE;
    
    [self.serviceThread start];
}

// Method of CBModule protocol
-(void) processService
{
    // Every NSThread need an individual NSAutoreleasePool to manage memory.
    NSAutoreleasePool *serviceThreadPool = [[NSAutoreleasePool alloc] init];
    
    [self initLocationManagerIfNecessary];
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
