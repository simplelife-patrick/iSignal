//
//  ISMapViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-9-1.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import "ISMapViewController.h"


@implementation ISMapViewController

// Manual Codes Begin

@synthesize mapView = _mapView;

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize mapAnnotations = _mapAnnotations;

- (void) mapAnnotationFromSignalRecord:(SignalRecord*) record
{
    if(nil != record)
    {
        ISMapAnnotation *annotation = [[ISMapAnnotation alloc] init];
        annotation.latitude = record.latitude;
        annotation.longitude = record.longitude;
        annotation.title = NSLocalizedString(@"STR_NOSIGNAL",nil);
        annotation.subtitle = [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:record.time];        
        
        [_mapAnnotations addObject:annotation];

        [annotation release];        
    }
}

- (void)rebuildMapAnnotations
{
    [_mapAnnotations removeAllObjects];
    NSArray *fetchedObjects = [_fetchedResultsController fetchedObjects];
    for (NSObject *obj in fetchedObjects) 
    {
        SignalRecord *signalRecord = (SignalRecord*)obj;
        [self mapAnnotationFromSignalRecord:signalRecord];
    }
    
    [_mapView removeAnnotations:_mapView.annotations];
    for (ISMapAnnotation *annotation in _mapAnnotations) 
    {
        [_mapView addAnnotation:annotation];
    }
}

- (void)relocateUser
{
    CLLocationCoordinate2D coordinate = _mapView.userLocation.location.coordinate; 
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, SPAN_LATITUDE, SPAN_LONGITUDE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:TRUE]; 
    
    [self rebuildMapAnnotations];    
}

- (void)initTabBarItem
{
    //    UIImage* itemImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
    UIImage* itemImage = nil;
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_MAP", nil) image:itemImage tag:TAG_MAPVIEW];
    self.tabBarItem = theItem;
    [theItem release];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        [self initTabBarItem];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self relocateUser];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc 
{
    [_fetchedResultsController release];
    [_mapAnnotations release];
    [_mapView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 3 map types: MKMapTypeStandard, MKMapTypeSatellite, MKMapTypeHybird
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    
    _mapAnnotations = [[NSMutableArray alloc] init];
    
    // Attach object reference of NSFetchedResultsController
    iSignalAppDelegate* appDelegate = (iSignalAppDelegate*) [CBUIUtils getAppDelegate];
    _fetchedResultsController = [appDelegate.coreDataModule obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    // Inject delegate(self) to NSFetchedResultsController object
    _fetchedResultsController.delegate = self;
}

- (void)viewDidUnload
{
    _fetchedResultsController = nil;
    
    _mapAnnotations = nil;
    
    _mapView = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Method of NSFetchedResultsControllerDelegate protocol
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{

}

// Method of NSFetchedResultsControllerDelegate protocol
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:

            break;
            
        case NSFetchedResultsChangeDelete:

            break;
    }
}

// Method of NSFetchedResultsControllerDelegate protocol
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            break;
        }   
        case NSFetchedResultsChangeDelete:
        {
            break;
        }   
        case NSFetchedResultsChangeUpdate:
        {
            break;
        }   
        case NSFetchedResultsChangeMove:
        {
            break;
        }
    }
}

// Method of NSFetchedResultsControllerDelegate protocol
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
}

// Method of MKMapViewDelegate protocol
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    if ([annotation isKindOfClass:[ISMapAnnotation class]])
    {
        // try to dequeue an existing pin view first

        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [_mapView dequeueReusableAnnotationViewWithIdentifier:ISMapAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:ISMapAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
//            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:self
//                            action:@selector(showDetails:)
//                  forControlEvents:UIControlEventTouchUpInside];
//            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

// Method of MKMapViewDelegate protocol
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}


// Manual Codes End

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
