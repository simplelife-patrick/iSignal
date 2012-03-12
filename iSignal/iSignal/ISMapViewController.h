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
#import "ISRecordDetailViewController.h"

@interface ISMapViewController : UIViewController <MKMapViewDelegate,NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *locateMeButton;
@property (retain, nonatomic) IBOutlet ISRecordDetailViewController *recordDetailViewController;

- (IBAction) locatePositionAndCenterMap:(id) sender;

@property (nonatomic, retain) NSMutableArray *mapAnnotations;

@end
