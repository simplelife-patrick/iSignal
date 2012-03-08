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
    if(nil != _signalRecord && 0 != _signalRecord.latitude && 0 != _signalRecord.longitude)
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
    return DETAILTABLE_SECTION_DETAIL_ITEM_COUNT;
}

// Method of UITableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CustomCellIdentifier = CELL_IDENTIFIER_SIGNALRECORD_DETAIL;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (nil == cell) 
    { 
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CustomCellIdentifier] autorelease];
    }    

    NSInteger rowIndex = [indexPath row];
    switch (rowIndex) 
    {
        case DETAILTABLE_SECTION_DETAIL_ITEM_CARRIER_INDEX:
        {
            cell.textLabel.text = DETAILTABLE_SECTION_DETAIL_ITEM_CARRIER_NAME;
            cell.detailTextLabel.text = _signalRecord.carrier;
            break;            
        }
        case DETAILTABLE_SECTION_DETAIL_ITEM_TYPE_INDEX:
        {
            cell.textLabel.text = DETAILTABLE_SECTION_DETAIL_ITEM_TYPE_NAME;
            cell.detailTextLabel.text = [CBTelephonyUtils signalQualityText:[_signalRecord.type intValue]];
            break;
        }
        case DETAILTABLE_SECTION_DETAIL_ITEM_TIME_INDEX:
        {
            cell.textLabel.text = DETAILTABLE_SECTION_DETAIL_ITEM_TIME_NAME;
            NSDate *time = _signalRecord.time;
            NSString *timeString = [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:time];
            cell.detailTextLabel.text = timeString;
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
    return DETAILTABLE_SECTION_NAME_DETAIL;
}

@end
