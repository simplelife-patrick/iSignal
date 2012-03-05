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
    //    UIImage* itemImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
    UIImage* itemImage = nil;
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_CONFIG", nil) image:itemImage tag:TAG_CONFIGVIEW];
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
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // TODO: Need to be updated once here are more than one section.

    // Only one section's item here
    return CONFIG_TABLE_SECTION_CONFIG_ITEM_COUNT;
}

// Method of UITableViewDataSource protocol
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) 
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//    // Configure the cell.
//    cell.textLabel.text = [self.configItemArray objectAtIndex: [indexPath row]];
    
    static NSString *CustomCellIdentifier = CELL_IDENTIFIER_APPCONFIG;
    ISConfigSwitcherCell *cell = (ISConfigSwitcherCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];  
    if (nil == cell) 
    {  
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *array = [mainBundle loadNibNamed:@"ISConfigSwitcherCell" owner:self options:nil];
        cell = [array objectAtIndex:0];  
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];  

        NSInteger rowIndex = [indexPath row];
        switch (rowIndex) 
        {
            case CONFIG_TABLE_SECTION_CONFIG_ITEM_RING_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_CONFIG_ITEM_RING_NAME;
                [cell.switcher setOn:[ISAppConfigs isRingAlarmOn]];
                [cell.switcher addTarget:self action:@selector(ringAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            }
            case CONFIG_TABLE_SECTION_CONFIG_ITEM_VIBRATE_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_CONFIG_ITEM_VIBRATE_NAME;
                [cell.switcher setOn:[ISAppConfigs isVibrateAlarmOn]];
                [cell.switcher addTarget:self action:@selector(vibrateAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            }
            case CONFIG_TABLE_SECTION_CONFIG_ITEM_LOCATION_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_CONFIG_ITEM_LOCATION_NAME;
                [cell.switcher setOn:[ISAppConfigs isLocationOn]];
                [cell.switcher addTarget:self action:@selector(locationStateChanged:) forControlEvents:UIControlEventValueChanged];
                if (![CBLocationManager isLocationServiceEnabled]) 
                {
                    [cell.switcher setEnabled:FALSE];
                }
            }
            default:
                break;
        }
        

    }
    
    return cell;
}

// Method of UITableViewDataSource protocol
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Only one section here
    return CONFIG_TABLE_SECTION_NAME_CONFIG;
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
