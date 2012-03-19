//
//  ISHelpViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISHelpViewController.h"

@implementation ISHelpViewController

// Manual Codes Begin
@synthesize helpTableView = _helpTableView;
@synthesize aboutViewController = _aboutViewController;
@synthesize versionHistoryViewController = _versionHistoryViewController;

// Method of UITableViewDelegate protocol
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSUInteger rowInSection = indexPath.row;
    
    switch (section) 
    {
        case TABLE_HELPITEM_SECTION_COPYRIGHT_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_VERSION_INDEX:
                {
                    break;
                }   
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_USERID_INDEX:
                {
                    break;
                }
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_REGISTERCODE_INDEX:
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
        case TABLE_HELPITEM_SECTION_ABOUT_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_ABOUT_INDEX:
                {
                    [self.navigationController pushViewController:_aboutViewController animated:TRUE];

                    break;
                }
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_VERSIONHISTORY_INDEX:
                {     
                    [self.navigationController pushViewController:_versionHistoryViewController animated:TRUE];
                    
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

// Method of UITableViewDataSource protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_HELPITEM_SECTION_COUNT;
}

// Private method
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *cellText = nil;
    NSString *cellDetailText = nil;
    NSInteger accessoryTypeVal = UITableViewCellAccessoryNone;
    UITableViewCellSelectionStyle selectionStyleVal = UITableViewCellSelectionStyleBlue;
    
    NSInteger section = indexPath.section;
    NSUInteger rowInSection = indexPath.row;
    switch (section) 
    {
        case TABLE_HELPITEM_SECTION_COPYRIGHT_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_VERSION_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_VERSION_NAME;
                    cellDetailText = [CBEnvironmentUtils applicationVersion];
                    selectionStyleVal = UITableViewCellSelectionStyleNone;
                    break;
                }   
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_USERID_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_USERID_NAME;
                    cellDetailText = NSLocalizedString(@"STR_USER_DEV", nil);
                    selectionStyleVal = UITableViewCellSelectionStyleNone;
                    break;
                }
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_REGISTERCODE_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_REGISTERCODE_NAME;
                    cellDetailText = NSLocalizedString(@"STR_VERSION_DEV", nil);                    
                    selectionStyleVal = UITableViewCellSelectionStyleNone;
                    break;
                }
                default:
                {
                    break;
                }
            }
            
            break;
        }
        case TABLE_HELPITEM_SECTION_ABOUT_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_ABOUT_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_ABOUT_ITEM_ABOUT_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_VERSIONHISTORY_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_ABOUT_ITEM_VERSIONHISTORY_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;                    
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
                    cellText = TABLE_HELPITEM_SECTION_MOREAPPS_ITEM_MOREAPPS_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator; 
                    selectionStyleVal = UITableViewCellSelectionStyleGray;
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
    
    cell.accessoryType = accessoryTypeVal;
    cell.selectionStyle = selectionStyleVal;
    cell.textLabel.text = cellText;
    cell.detailTextLabel.text = cellDetailText;
}

// Method of UITableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = TABLECELL_TYPE_HELPITEM;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];         
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

// Method of UITableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) 
    {
        case TABLE_HELPITEM_SECTION_COPYRIGHT_INDEX:
        {
            return TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_COUNT;
        }
        case TABLE_HELPITEM_SECTION_ABOUT_INDEX:
        {
            return TABLE_HELPITEM_SECTION_ABOUT_ITEM_COUNT;
        }
        case TABLE_HELPITEM_SECTION_MOREAPPS_INDEX:
        {
            return TABLE_HELPITEM_SECTION_MOREAPPS_ITEM_COUNT;
        }
    }
    
    return 0;
}

// Method of UITableViewDataSource protocol
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) 
    {
        case TABLE_HELPITEM_SECTION_COPYRIGHT_INDEX:
        {
            return TABLE_HELPITEM_SECTION_COPYRIGHT_NAME;
        }
        case TABLE_HELPITEM_SECTION_ABOUT_INDEX:
        {
            return TABLE_HELPITEM_SECTION_ABOUT_NAME;
        }
        case TABLE_HELPITEM_SECTION_MOREAPPS_INDEX:
        {
            return nil;
        }
    }    
    
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.navigationItem.title = NSLocalizedString(@"STR_TAB_HELP", nil);
    }
    return self;
}

- (void)dealloc 
{
    [_helpTableView release];
    [_aboutViewController release];
    [_versionHistoryViewController release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setHelpTableView:nil];
    [self setAboutViewController:nil];
    [self setVersionHistoryViewController:nil];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
