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
@synthesize helpTableView;

@synthesize detailViewController = _detailViewController;
@synthesize aboutTextView = _aboutTextView;

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
                    _aboutTextView.editable = FALSE;
                    _aboutTextView.text = NSLocalizedString(@"STR_HELP_INFO", nil);                    
                    _detailViewController.view = _aboutTextView;
                    [self.navigationController pushViewController:_detailViewController animated:TRUE];
                    break;
                }
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_NEWFEATURES_INDEX:
                {                   
                    break;
                }
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_OFFICIALWEBSITE_INDEX:
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
                    break;
                }   
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_USERID_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_USERID_NAME;
                    break;
                }
                case TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_REGISTERCODE_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_COPYRIGHT_ITEM_REGISTERCODE_NAME;
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
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_NEWFEATURES_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_ABOUT_ITEM_NEWFEATURES_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;                    
                    break;
                }
                case TABLE_HELPITEM_SECTION_ABOUT_ITEM_OFFICIALWEBSITE_INDEX:
                {
                    cellText = TABLE_HELPITEM_SECTION_ABOUT_ITEM_OFFICIALWEBSITE_NAME;
                    cellDetailText = TABLE_HELPITEM_SECTION_ABOUT_ITEM_OFFICIALWEBSITE_DETAIL;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
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

    }
    return self;
}

- (void)dealloc 
{
    [helpTableView release];
    [_detailViewController release];
    [_aboutTextView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setHelpTableView:nil];
    [self setDetailViewController:nil];
    [self setAboutTextView:nil];
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
