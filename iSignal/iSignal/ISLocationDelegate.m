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

@synthesize curLocation;

//-(void) getCurPosition  
//{  
//    //开始探测自己的位置  
//    if (locationManager==nil)   
//    {  
//        locationManager =[[CLLocationManager alloc] init];  
//    }  
//    
//    
//    if ([CLLocationManager locationServicesEnabled])   
//    {  
//        locationManager.delegate=self;  
//        locationManager.desiredAccuracy=kCLLocationAccuracyBest;  
//        locationManager.distanceFilter=10.0f;  
//        [locationManager startUpdatingLocation];  
//    }  
//}  

////响应当前位置的更新，在这里记录最新的当前位置  
//- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation  
//            fromLocation:(CLLocation *)oldLocation   
//{  
//    NSLog(@"newLocation:%@",[newLocation description]);  
//    
//    //保存新位置  
//    curLocation=newLocation.coordinate;  
//}

// Manual Coes End

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
