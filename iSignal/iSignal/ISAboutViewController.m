//
//  ISAboutViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISAboutViewController.h"

@interface ISAboutViewController ()

@end

@implementation ISAboutViewController

@synthesize aboutTableView;

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
        case TABLE_ABOUTITEM_SECTION_ABOUT_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_ABOUTITEM_SECTION_ABOUT_ITEM_ABOUT_INDEX:
                {
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
        case TABLE_ABOUTITEM_SECTION_AUTHOR_INDEX:
        {
            switch (rowInSection) 
            {
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEBSITE_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEBSITE_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALEMAIL_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALEMAIL_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;                    
                    break;
                }
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEIBO_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEIBO_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryNone;
                    break;
                }
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALTWITTER_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALTWITTER_NAME;
                    accessoryTypeVal = UITableViewCellAccessoryNone;
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
    return TABLE_ABOUTITEM_SECTION_COUNT;
}

// Method of TableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = TABLECELL_TYPE_ABOUTITEM;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];         
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}

// Method of TableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TABLE_ABOUTITEM_SECTION_COUNT;
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
    [self setAboutTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [aboutTableView release];
    [super dealloc];
}
@end
