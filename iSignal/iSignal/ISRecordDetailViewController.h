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

@interface ISRecordDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) SignalRecord *signalRecord;

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UITableView *detailTableView;

- (IBAction) onClickLeftBarButton:(id) sender;

@end
