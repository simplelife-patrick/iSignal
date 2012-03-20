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
                    UILabel *label = (UILabel *)[cell viewWithTag:1];

                    CGRect cellFrame = [cell frame];
                    cellFrame.origin = CGPointMake(0, 0);
                    
                    label.text = NSLocalizedString(@"STR_HELP_INFO", nil);
                    CGRect rect = CGRectInset(cellFrame, 4, 4);
                    label.frame = rect;
                    [label sizeToFit];
                    if (label.frame.size.height > 46) 
                    {
                        cellFrame.size.height = 60 + label.frame.size.height - 46;
                    }
                    else 
                    {
                        cellFrame.size.height = 60;
                    }
                    [cell setFrame:cellFrame];
                    
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
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALEMAIL_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALEMAIL_NAME;
                    cellDetailText = AUTHOR_EMAIL;
                    accessoryTypeVal = UITableViewCellAccessoryDisclosureIndicator;                    
                    break;
                }
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEIBO_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALWEIBO_NAME;
                    cellDetailText = AUTHOR_WEIBO;
                    accessoryTypeVal = UITableViewCellAccessoryNone;
                    selectionStyleVal = UITableViewCellSelectionStyleNone;
                    break;
                }
                case TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALTWITTER_INDEX:
                {
                    cellText = TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_OFFICIALTWITTER_NAME;
                    cellDetailText = AUTHOR_TWITTER;                    
                    selectionStyleVal = UITableViewCellSelectionStyleNone;
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
    NSInteger section = indexPath.section;
    switch (section) 
    {
        case TABLE_ABOUTITEM_SECTION_ABOUT_INDEX:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLECELL_TYPE_ABOUTITEM];
            if (nil == cell) 
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLECELL_TYPE_ABOUTITEM] autorelease];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.tag = 1;
                label.lineBreakMode = UILineBreakModeTailTruncation;
                label.highlightedTextColor = [UIColor whiteColor];
                label.numberOfLines = 0;
                label.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
                label.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:label];
                [label release];                
            }
            
            [self configureCell:cell atIndexPath:indexPath];
            return cell;
        }
        case TABLE_ABOUTITEM_SECTION_AUTHOR_INDEX:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLECELL_TYPE_GENERIC];
            if (nil == cell) 
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TABLECELL_TYPE_GENERIC] autorelease];         
            }

            [self configureCell:cell atIndexPath:indexPath];
            return cell;
        }
        default:
        {
            break;
        }
    }
    
    return nil;
}

// Method of TableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) 
    {
        case TABLE_ABOUTITEM_SECTION_ABOUT_INDEX:
        {
            return TABLE_ABOUTITEM_SECTION_ABOUT_ITEM_COUNT;
        }
        case TABLE_ABOUTITEM_SECTION_AUTHOR_INDEX:
        {
            return TABLE_ABOUTITEM_SECTION_AUTHOR_ITEM_COUNT;
        }
        default:
        {
            break;
        }
    }
    
    return 0;
}

// Method of UITableViewDataSource protocol
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) 
    {
        case TABLE_ABOUTITEM_SECTION_ABOUT_INDEX:
        {
            return nil;
        }
        case TABLE_ABOUTITEM_SECTION_AUTHOR_INDEX:
        {
            return TABLE_ABOUTITEM_SECTION_AUTHOR_NAME;
        }
        case TABLE_HELPITEM_SECTION_MOREAPPS_INDEX:
        {
            return nil;
        }
    }    
    
    return nil;
}

// Method of UITableViewDelegate protocol
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
