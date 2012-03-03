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
@synthesize locateMeButton = _locateMeButton;

@synthesize mapAnnotations = _mapAnnotations;

- (IBAction) locatePositionAndCenterMap:(id) sender
{
    [self relocateUser];
}

- (void)mapAnnotationFromSignalRecord:(SignalRecord*) record
{
    if(nil != record && nil != record.latitude && nil != record.longitude)
    {
        ISMapAnnotation *annotation = [[ISMapAnnotation alloc] init];
        annotation.latitude = record.latitude;
        annotation.longitude = record.longitude;
        annotation.title = NSLocalizedString(@"STR_NOSIGNAL",nil);
        annotation.subtitle = [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:record.time];        
        
        [_mapAnnotations addObject:annotation];
        [_mapView addAnnotation:annotation];
        
        [annotation release];        
    }
}

- (void)rebuildMapAnnotations
{
    NSFetchedResultsController* _fetchedResultsController = [self getNSFetchedResultsController]; 
    
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapAnnotations removeAllObjects];
    NSArray *fetchedObjects = [_fetchedResultsController fetchedObjects];
    for (NSObject *obj in fetchedObjects) 
    {
        SignalRecord *signalRecord = (SignalRecord*)obj;
        [self mapAnnotationFromSignalRecord:signalRecord];
    }
}

- (void)relocateUser
{
    CLLocationCoordinate2D coordinate = _mapView.userLocation.location.coordinate; 
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, SPAN_LATITUDE, SPAN_LONGITUDE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:TRUE]; 
    
    _mapView.showsUserLocation = TRUE;
    
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
        [self initTabBarItem];
        
        _mapAnnotations = [[NSMutableArray alloc] init];
    }
    return self;
}

// Method of UIViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerNSFetchedResultsControllerDelegate];  
}

// Method of UIViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self relocateUser];
}

// Method of UIViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

// Method of UIViewController
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

// Private method
- (NSFetchedResultsController*) getNSFetchedResultsController
{
    iSignalAppDelegate* appDelegate = (iSignalAppDelegate*) [CBUIUtils getAppDelegate];
    return [appDelegate.coreDataModule obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];   
}

// Private method
- (void) registerNSFetchedResultsControllerDelegate
{
    iSignalAppDelegate* appDelegate = (iSignalAppDelegate*) [CBUIUtils getAppDelegate];
    [appDelegate.coreDataModule registerNSFetchedResultsControllerDelegate:gFetchedResultsControllerIdentifier_signalRecord andDelegate:self];        
}

- (void)dealloc 
{
    [_mapAnnotations release];
    [_mapView release];
    
    [_locateMeButton release];
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
    // Inject delegate(self) to MKMapViewDelegate object
    _mapView.delegate = self;
    
    [self.navigationController pushViewController:self animated:TRUE];
    
    [self registerNSFetchedResultsControllerDelegate];    
}

- (void)viewDidUnload
{
    _mapAnnotations = nil;
    _mapView = nil;
    
    [self setLocateMeButton:nil];
    [super viewDidUnload];
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
            SignalRecord *record = (SignalRecord*)[controller objectAtIndexPath:newIndexPath];
            [self mapAnnotationFromSignalRecord:record];
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

// Method of MKMapViewDelegate protocol
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}

// Manual Codes End

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
