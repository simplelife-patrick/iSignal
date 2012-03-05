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
    if(nil != _signalRecord && nil != _signalRecord.latitude && nil != _signalRecord.longitude)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_signalRecord.latitude doubleValue], [_signalRecord.longitude doubleValue]);
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, SPAN_LATITUDE, SPAN_LONGITUDE);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        [_mapView setRegion:adjustedRegion animated:TRUE]; 
        
        [self mapAnnotationFromSignalRecord];          
    }
}

// Private method
- (void)mapAnnotationFromSignalRecord
{
    if(nil != _signalRecord && nil != _signalRecord.latitude && nil != _signalRecord.longitude)
    {
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
    // TODO: Need to be updated once here are more than one section.
    return DETAILTABLE_SECTION_COUNT;
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
        case DETAILTABLE_SECTION_DETAIL_ITEM_TYPE_INDEX:
        {
            cell.textLabel.text = CONFIG_TABLE_SECTION_CONFIG_ITEM_RING_NAME;
            cell.detailTextLabel.text = _signalRecord.type;
            break;
        }
        case DETAILTABLE_SECTION_DETAIL_ITEM_TIME_INDEX:
        {
            cell.textLabel.text = CONFIG_TABLE_SECTION_CONFIG_ITEM_VIBRATE_NAME;
            NSDate *time = _signalRecord.time;
            NSString *timeString = [CBDateUtils dateStringInLocalTimeZoneWithStandardFormat:time];
            cell.textLabel.text = timeString;
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
