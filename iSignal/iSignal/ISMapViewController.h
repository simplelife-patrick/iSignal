//
//  ISMapViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-1.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

#define SPAN_LONGITUDE 2000
#define SPAN_LATITUDE 2000

@interface ISMapViewController : UIViewController

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
