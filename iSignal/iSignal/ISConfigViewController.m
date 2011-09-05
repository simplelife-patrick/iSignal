//
//  ISConfigViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISConfigViewController.h"

#import "ISSwitchViewController.h"

@implementation ISConfigViewController

// Manual Codes Begin

- (void)dealloc 
{
    [super dealloc];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // TODO: Need to be updated once here are more than one section.

    // Only one section's item here
    return CONFIG_TABLE_SECTION_0_ITEM_COUNT;
}

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
    
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
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
            case CONFIG_TABLE_SECTION_0_ITEM_0_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_0_ITEM_0_NAME;
                [cell.switcher setOn:[ISAppConfigs isRingAlarmOn]];
                [cell.switcher addTarget:self action:@selector(ringAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            }
            case CONFIG_TABLE_SECTION_0_ITEM_1_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_0_ITEM_1_NAME;
                [cell.switcher setOn:[ISAppConfigs isVibrateAlarmOn]];
                [cell.switcher addTarget:self action:@selector(vibrateAlarmStateChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            }
            case CONFIG_TABLE_SECTION_0_ITEM_2_INDEX:
            {
                cell.switcherLabel.text = CONFIG_TABLE_SECTION_0_ITEM_2_NAME;
                [cell.switcher setOn:[ISAppConfigs isLocationOn]];
                [cell.switcher addTarget:self action:@selector(locationStateChanged) forControlEvents:UIControlEventValueChanged];
            }
            default:
                break;
        }
        

    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Only one section here
    return CONFIG_TABLE_SECTION_0_NAME;
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
    // Do any additional setup after loading the view from its nib.
    
    // Initialize table data
    
    // Initialize config data
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Manual Codes End

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
