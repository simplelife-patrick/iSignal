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

@interface ISRecordsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, retain, readonly) NSFetchedResultsController* fetchedResultsController;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end