//
//  ISRecordDetailViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-5.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISRecordDetailViewController.h"

@implementation ISRecordDetailViewController

@synthesize signalRecord = _signalRecord;
@synthesize mapView = _mapView;
@synthesize detailTableView = _detailTableView;

- (IBAction) onClickLeftBarButton:(id) sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

// Private method
- (void)gotoLocation
{
    if(nil != _signalRecord)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_signalRecord.latitude doubleValue], [_signalRecord.longitude doubleValue]);
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, ISMAPVIEW_SPAN_LATITUDE, ISMAPVIEW_SPAN_LONGITUDE);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        [_mapView setRegion:adjustedRegion animated:FALSE]; 
        
        [self mapAnnotationFromSignalRecord];          
    }
    else
    {
        _mapView.hidden = TRUE;
    }
}

// Private method
- (void)mapAnnotationFromSignalRecord
{
    if(nil != _signalRecord && nil != _signalRecord.latitude && nil != _signalRecord.longitude)
    {
        [_mapView removeAnnotations:_mapView.annotations];
        
        ISMapAnnotation *annotation = [[ISMapAnnotation alloc] init];
        
        annotation.latitude = _signalRecord.latitude;
        annotation.longitude = _signalRecord.longitude;
        [_mapView addAnnotation:annotation];
        
        [annotation release];        
    }
}

// Method of UIViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_detailTableView reloadData]; 
    [self gotoLocation]; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setDetailTableView:nil];
    [self setSignalRecord:nil];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [_mapView release];
    [_detailTableView release];
    [_signalRecord release];

    [super dealloc];
}

// Method of UITableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_COUNT;
}

// Method of UITableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    
    static NSString *CustomCellIdentifier = TABLECELL_TYPE_SIGNALRECORDDETAIL;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (nil == cell) 
    { 
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CustomCellIdentifier] autorelease];
    }    

    NSInteger rowIndex = [indexPath row];
    switch (rowIndex) 
    {
        case TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_CARRIER_INDEX:
        {
            cell.textLabel.text = TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_NAME_CARRIER;
            cell.detailTextLabel.text = _signalRecord.carrier;
            break;            
        }
        case TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_TYPE_INDEX:
        {
            cell.textLabel.text = TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_TYPE_NAME;
            cell.detailTextLabel.text = [CBTelephonyUtils signalQualityText:[_signalRecord.type intValue]];
            break;
        }
        case TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_TIME_INDEX:
        {
            cell.textLabel.text = TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_TIME_NAME;
            NSDate *time = _signalRecord.time;
            NSString *timeString = [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:time];
            cell.detailTextLabel.text = timeString;
            break;
        }
        case TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_SPEED_INDEX:
        {
            cell.textLabel.text = TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_SPEED_NAME;
            double speedVal = [_signalRecord.speed doubleValue];
            NSString *speedString = (0 < speedVal) ? [NSString stringWithFormat:@"%.2f", speedVal] : NSLocalizedString(@"STR_UNAVAILABLE", nil);
            cell.detailTextLabel.text = speedString;
            break;
        }
        case TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_ADDRESS_INDEX:
        {
            cell.textLabel.text = TABLE_SIGNALRECORDDETAIL_SECTION_DETAIL_ITEM_ADDRESS_NAME;            
            
            CLPlacemark* placemark = [appDelegate.locationModule reverseGeocodeLocationToPrimaryPlaceMark];
            if (placemark) 
            {
                cell.detailTextLabel.text = placemark.country;
            }
            break;
        }
        default:
        {
            break;
        }
    }
    
    return cell;
}

// Method of UITableViewDataSource protocol
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return TABLE_SIGNALRECORDDETAIL_NAME_DETAIL;
}

@end
