//
//  ISVersionHistoryViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISVersionHistoryViewController.h"

@interface ISVersionHistoryViewController ()

@end

@implementation ISVersionHistoryViewController

@synthesize versionHistoryTableView;

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
        case TABLE_VERSIONITEM_SECTION_0_1_0_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_VERSIONITEM_SECTION_0_1_0_INDEX:
                {
                    cellDetailText = TABLE_VERSIONITEM_SECTION_0_1_0_ITEM_DESCRIPTION;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_VERSIONITEM_SECTION_COUNT;
}

// Method of TableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = TABLECELL_TYPE_VERSIONITEM;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];         
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

// Method of TableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TABLE_VERSIONITEM_SECTION_ITEM_COUNT;
}

// Method of UITableViewDataSource protocol
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case TABLE_VERSIONITEM_SECTION_0_1_0_INDEX:
        {
            return TABLE_VERSIONITEM_SECTION_0_1_0_NAME;
        }   
        default:
        {
            break;
        }
    }
    
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setVersionHistoryTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [versionHistoryTableView release];
    [super dealloc];
}
@end
