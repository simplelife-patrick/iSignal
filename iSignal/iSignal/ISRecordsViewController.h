//
//  ISRecordsViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-1.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ISRecordDetailViewController.h"

#define KEY_CELL_IDENTIFIER @"Cell"
#define KEY_CELL_SIGNALRECORD_IDENTIFIER @"SignalRecordCell"

@interface ISRecordsViewController : UIViewController <UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (retain, nonatomic, readonly) IBOutlet UIBarButtonItem *leftBarButton;
@property (retain, nonatomic, readonly) IBOutlet UIBarButtonItem *rightBarButton;

@property (nonatomic) BOOL deleteEnabled;
@property (nonatomic) BOOL multiselectEnabled;

@property (retain, nonatomic, readonly) IBOutlet UITableView *tableView;
@property (retain, nonatomic, readonly) IBOutlet ISRecordDetailViewController *recordDetailViewController;

@property (retain, nonatomic, readonly)	NSMutableDictionary *deletingRecords;

- (IBAction) deleteRecords:(id) sender;
- (IBAction) selectRecords:(id) sender;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end