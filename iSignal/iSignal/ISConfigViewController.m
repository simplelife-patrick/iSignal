//
//  ISConfigViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISConfigViewController.h"

@implementation ISConfigViewController

// Manual Codes Begin

- (void)initTabBarItem
{
    UIImage* itemImage = [UIImage imageNamed:@"tab_config.png"];
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_CONFIG", nil) image:itemImage tag:TABVIEW_INDEX_CONFIGVIEW];
    self.tabBarItem = theItem;
    [theItem release];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        [self initTabBarItem];
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

// Method of UITableViewDataSource protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_CONFIG_SECTION_COUNT;
}

// Method of UITableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    switch (section) 
    {
        case TABLE_CONFIG_SECTION_CONFIG_INDEX:
        {
            return TABLE_CONFIG_SECTION_CONFIG_ITEM_COUNT;
        }
        case TABLE_CONFIG_SECTION_DATA_INDEX:
        {
            return TABLE_CONFIG_SECTION_DATA_ITEM_COUNT;
        }
        default:
        {
            break;
        }
    }
    return 0;
}

// Method of UITableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = nil;
    
    NSInteger section = indexPath.section;
    NSInteger rowInSection = indexPath.row;
    
    switch (section) 
    {
        case TABLE_CONFIG_SECTION_CONFIG_INDEX:
        {
            ISTableViewSwitcherCell *switcherCell = (ISTableViewSwitcherCell *)[tableView dequeueReusableCellWithIdentifier:TABLECELL_TYPE_APPCONFIG_SWITCHER];  
            if (nil == switcherCell) 
            {  
                NSBundle *mainBundle = [NSBundle mainBundle];
                NSArray *array = [mainBundle loadNibNamed:NIB_TABLEVIEW_SWITCHERCELL owner:self options:nil];
                switcherCell = [array objectAtIndex:0];  
                [switcherCell setSelectionStyle:UITableViewCellSelectionStyleNone];  

                switch (rowInSection) 
                {
                    case TABLE_CONFIG_SECTION_CONFIG_ITEM_RING_INDEX:
                    {
                        switcherCell.switcherLabel.text = TABLE_CONFIG_SECTION_CONFIG_ITEM_RING_NAME;
                        [switcherCell.switcher setOn:[ISAppConfigs isRingAlarmOn]];
                        [switcherCell.switcher addTarget:self action:@selector(ringAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                        cell = switcherCell;
                        break;
                    }
                    case TABLE_CONFIG_SECTION_CONFIG_ITEM_VIBRATE_INDEX:
                    {
                        switcherCell.switcherLabel.text = TABLE_CONFIG_SECTION_CONFIG_ITEM_VIBRATE_NAME;
                        [switcherCell.switcher setOn:[ISAppConfigs isVibrateAlarmOn]];
                        [switcherCell.switcher addTarget:self action:@selector(vibrateAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                        cell = switcherCell;
                        break;
                    }
                    case TABLE_CONFIG_SECTION_CONFIG_ITEM_LOCATION_INDEX:
                    {
                        switcherCell.switcherLabel.text = TABLE_CONFIG_SECTION_CONFIG_ITEM_LOCATION_NAME;
                        [switcherCell.switcher setOn:[ISAppConfigs isLocationOn]];
                        [switcherCell.switcher addTarget:self action:@selector(locationStateChanged:) forControlEvents:UIControlEventValueChanged];
                        if (![CBLocationManager isLocationServiceEnabled]) 
                        {
                            [switcherCell.switcher setEnabled:FALSE];
                        }
                        cell = switcherCell;                        
                        break;
                    }
                    case TABLE_CONFIG_SECTION_CONFIG_ITEM_NOTIFICATION_INDEX:
                    {
                        switcherCell.switcherLabel.text = TABLE_CONFIG_SECTION_CONFIG_ITEM_NOTIFICATION_NAME;
                        [switcherCell.switcher setOn:[ISAppConfigs isNotificationOn]];
                        [switcherCell.switcher addTarget:self action:@selector(notificationStateChanged:) forControlEvents:UIControlEventValueChanged];
                        cell = switcherCell;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            
            break;
        }
        case TABLE_CONFIG_SECTION_DATA_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_CONFIG_SECTION_DATA_ITEM_DATASOURCE_INDEX:
                {
                    ISTableViewSegmentCell *segmentCell = (ISTableViewSegmentCell *)[ tableView dequeueReusableCellWithIdentifier:TABLECELL_TYPE_APPCONFIG_SEGEMENT];
                    if (nil == segmentCell) 
                    {
                        NSBundle *mainBundle = [NSBundle mainBundle];
                        NSArray *array = [mainBundle loadNibNamed:NIB_TABLEVIEW_SEGMENTCELL owner:self options:nil];
                        segmentCell = [array objectAtIndex:0];  
                        [segmentCell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
                        
                        segmentCell.segmentLabel.text = NSLocalizedString(@"STR_SIGNAL_SOURCE", nil);
                        [segmentCell.segmentControl setTitle:NSLocalizedString(@"STR_REAL_SIGNAL", nil) forSegmentAtIndex:0];
                        [segmentCell.segmentControl setTitle:NSLocalizedString(@"STR_DUMMY_SIGNAL", nil) forSegmentAtIndex:1];
                        NSInteger segmentIndex = [ISAppConfigs isTrackingRealSignal] ? 0 : 1;
                        [segmentCell.segmentControl setSelectedSegmentIndex:segmentIndex];
                        [segmentCell.segmentControl setEnabled:FALSE forSegmentAtIndex:0];
                        segmentCell.segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;                        
                        [segmentCell.segmentControl addTarget:self action:@selector(signalSourceChanged:) forControlEvents:(UIControlEventValueChanged)];
                        
                        
                        cell = segmentCell;
                    }
                    break;
                }                    
                case TABLE_CONFIG_SECTION_DATA_ITEM_CLEARDATA_INDEX:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:TABLECELL_TYPE_GENERIC];
                    if (nil == cell) 
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLECELL_TYPE_GENERIC] autorelease];  
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.textLabel.text = NSLocalizedString(@"STR_DATA_CLEAR", nil);
                    }
                    
                    break;
                }   
                default:
                {
                    break;
                }
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
    switch (section) 
    {
        case TABLE_CONFIG_SECTION_CONFIG_INDEX:
        {
            return TABLE_CONFIG_SECTION_NAME_CONFIG;
        }
        case TABLE_CONFIG_SECTION_DATA_INDEX:
        {
            return TABLE_CONFIG_SECTION_DATA_NAME;
        }
        default:
        {
            return nil;
        }
    }
}

// Method of UITableViewDelegate protocol
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSUInteger rowInSection = indexPath.row;
    
    switch (section) 
    {
        case TABLE_CONFIG_SECTION_CONFIG_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_CONFIG_SECTION_CONFIG_ITEM_RING_INDEX:
                {
                    break;
                }   
                case TABLE_CONFIG_SECTION_CONFIG_ITEM_VIBRATE_INDEX:
                {
                    break;
                }
                case TABLE_CONFIG_SECTION_CONFIG_ITEM_LOCATION_INDEX:
                {
                    break;
                }
                case TABLE_CONFIG_SECTION_CONFIG_ITEM_NOTIFICATION_INDEX:
                {
                    break;
                }                    
                default:
                {
                    break;
                }
            }
            
            break;
        }
        case TABLE_CONFIG_SECTION_DATA_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_CONFIG_SECTION_DATA_ITEM_DATASOURCE_INDEX:
                {
                    break;
                }
                case TABLE_CONFIG_SECTION_DATA_ITEM_CLEARDATA_INDEX:
                {     
                    [self dataClearStarted:self];
                    break;
                }
                default:
                {
                    break;
                }
            }
            
            break;
        }
        case TABLE_HELPITEM_SECTION_MOREAPPS_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_HELPITEM_SECTION_MOREAPPS_ITEM_MOREAPPS_INDEX:
                {                   
                    break;
                }   
                default:
                {
                    break;
                }
            }
            
            break;
        }
        default:
        {
            break;
        }
    }     
}

// Method of UITableViewDelegate protocol
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)ringAlarmStateChanged:(id) sender
{
    if(nil != sender && ([sender isKindOfClass:[UISwitch class]]))
    {
        UISwitch *switcher = (UISwitch*) sender;
        [ISAppConfigs setRingAlarmOn:[switcher isOn]];
    }
}

- (void)vibrateAlarmStateChanged:(id) sender
{
    if(nil != sender && ([sender isKindOfClass:[UISwitch class]]))
    {
        UISwitch *switcher = (UISwitch*) sender;
        [ISAppConfigs setVibrateAlarmOn:[switcher isOn]];
    }   
}

- (void)locationStateChanged:(id) sender
{
    if(nil != sender && ([sender isKindOfClass:[UISwitch class]]))
    {
        UISwitch *switcher = (UISwitch*) sender;
        [ISAppConfigs setLocationOn:[switcher isOn]];
    }
}

- (void)notificationStateChanged:(id) sender
{
    if(nil != sender && ([sender isKindOfClass:[UISwitch class]]))
    {
        UISwitch *switcher = (UISwitch*) sender;
        [ISAppConfigs setNotificationOn:[switcher isOn]];
    }      
}

// Method of UIAlertViewDelegate protocol
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) 
    {
        case 0:
        {
            break;
        }
        case 1:
        {
            [self dataClearCommitted];            
            break;
        }
        default:
        {
            break;
        }
    }
}

// Private method
- (void)dataClearCommitted
{
    iSignalAppDelegate* appDelegate = (iSignalAppDelegate*) [CBUIUtils getAppDelegate];
    NSFetchedResultsController* _fetchedResultsController = [appDelegate.coreDataModule obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    
    NSManagedObjectContext *context = [_fetchedResultsController managedObjectContext];    
    
    NSError ** error;
    // retrieve the store URL
    NSURL * storeURL = [[context persistentStoreCoordinator] URLForPersistentStore:[[[context persistentStoreCoordinator] persistentStores] lastObject]];
    // lock the current context
    [context lock];
    [context reset];//to drop pending changes
    //delete the store from the current managedObjectContext
    if ([[context persistentStoreCoordinator] removePersistentStore:[[[context persistentStoreCoordinator] persistentStores] lastObject] error:error])
    {
        // remove the file containing the data
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:error];
        //recreate the store like in the  appDelegate method
        [[context persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:error];//recreates the persistent store
    }
    [context unlock]; 
}

- (void)dataClearStarted:(id) sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"STR_CONFIRM", nil) message:NSLocalizedString(@"STR_DATA_CLEAR_ALERT", nil)
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"STR_CANCEL", nil) otherButtonTitles:NSLocalizedString(@"STR_OK", nil), nil];
	[alert show];
	[alert release];    
}

- (void)signalSourceChanged:(id) sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

// Manual Codes End

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
