//
//  ISRecordsViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-1.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#define KEY_CELL_IDENTIFIER @"Cell"
#define KEY_CELL_CUSTOMER_IDENTIFIER @"CustomCellIdentifier"

#define DB_TABLE_SIGNALRECORD_CACHE @"SignalRecord_CoreData_Cache"
#define DB_TABLE_SIGNALRECORD @"SignalRecord"
#define DB_TABLE_SIGNALRECORD_FIELD_TIME @"time"
#define DB_TABLE_SIGNALRECORD_FIELD_ISSYNC @"isSync"
#define DB_TABLE_SIGNALRECORD_FIELD_LATITUDE @"latitude"
#define DB_TABLE_SIGNALRECORD_FIELD_LONGITUDE @"longitude"
#define DB_TABLE_SIGNALRECORD_FIELD_TAG @"tag"
#define DB_TABLE_SIGNALRECORD_FIELD_TYPE @"type"

#define DB_TABLE_SIGNALRECORD_VALUE_SIGNALLOSS 0


#define DB_FETCH_BTACH_SIZE 20

@interface ISRecordsViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) IBOutlet UITableViewController *recordsTableViewController;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (NSFetchedResultsController *)initFetchedResultsController;

@end
