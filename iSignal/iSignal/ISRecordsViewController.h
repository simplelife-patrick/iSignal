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

#define DB_FETCH_BTACH_SIZE 20

@interface ISRecordsViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) IBOutlet UITableViewController *recordsTableViewController;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
