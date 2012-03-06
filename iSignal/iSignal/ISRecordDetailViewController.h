//
//  ISRecordDetailViewController.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-5.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

// TODO: Config Table Properties should be put in xml file which can be parsed by a tool class.
#define DETAILTABLE_SECTION_COUNT 1
#define DETAILTABLE_SECTION_INDEX_DETAIL 0
#define DETAILTABLE_SECTION_NAME_DETAIL NSLocalizedString(@"STR_DETAIL", nil)

#define DETAILTABLE_SECTION_DETAIL_ITEM_COUNT 3
#define DETAILTABLE_SECTION_DETAIL_ITEM_CARRIER_INDEX 0
#define DETAILTABLE_SECTION_DETAIL_ITEM_CARRIER_NAME NSLocalizedString(@"STR_CARRIER", nil)
#define DETAILTABLE_SECTION_DETAIL_ITEM_TYPE_INDEX 1
#define DETAILTABLE_SECTION_DETAIL_ITEM_TYPE_NAME NSLocalizedString(@"STR_TYPE", nil)
#define DETAILTABLE_SECTION_DETAIL_ITEM_TIME_INDEX 2
#define DETAILTABLE_SECTION_DETAIL_ITEM_TIME_NAME NSLocalizedString(@"STR_TIME", nil)

#define CELL_IDENTIFIER_SIGNALRECORD_DETAIL @"CellIdentifier_SignalRecordDetail"

@interface ISRecordDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) SignalRecord *signalRecord;

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UITableView *detailTableView;

- (IBAction) onClickLeftBarButton:(id) sender;

@end
