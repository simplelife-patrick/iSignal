//
//  ISMapViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-1.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

#import "ISMapAnnotation.h"
#import "SignalRecord.h"

#define SPAN_LONGITUDE 2000
#define SPAN_LATITUDE 2000

@interface ISMapViewController : UIViewController <NSFetchedResultsControllerDelegate, MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (retain, nonatomic, readonly) NSFetchedResultsController* fetchedResultsController;

@property (nonatomic, retain) NSMutableArray *mapAnnotations;

@end
