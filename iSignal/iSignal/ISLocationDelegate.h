//
//  ISLocationDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-30.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface ISLocationDelegate : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;    
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic) CLLocationCoordinate2D curLocation;

//-(void) getCurLocation;

@end
