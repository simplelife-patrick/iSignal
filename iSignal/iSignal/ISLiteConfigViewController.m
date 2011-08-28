//
//  ISLiteConfigViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISLiteConfigViewController.h"

#import "SwitchViewController.h"

@implementation ISLiteConfigViewController

// Manual Codes Begin

@synthesize backButton;

@synthesize configItemArray;
@synthesize configSectionArray;

- (void)dealloc 
{
    [configSectionArray release];
    [configItemArray release];
    [backButton release];
    [super dealloc];
}

- (IBAction)switchToLiteView:(id)sender
{
    UIViewController* parentViewController = [ISUIUtils getViewControllerFromView:[self.view superview]];
    if([parentViewController isKindOfClass:[SwitchViewController class]])
    {
        [((SwitchViewController*)parentViewController) switchView:TAG_LITE_VIEW];
    }  
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // TODO: Need to be updated once here are more than one section.
    return [self.configItemArray count];
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
    ConfigSwitcherCell *cell = (ConfigSwitcherCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];  
    if (nil == cell) 
    {  
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *array = [mainBundle loadNibNamed:@"ConfigSwitcherCell" owner:self options:nil];
        cell = [array objectAtIndex:0];  
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];  
    }  

    cell.switcherLabel.text = [self.configItemArray objectAtIndex:[indexPath row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [configSectionArray objectAtIndex:section];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.configItemArray = [[NSArray alloc]initWithObjects:NSLocalizedString(@"STR_RING" , nil), NSLocalizedString(@"STR_VIBRATE", nil) ,nil];
    
    self.configSectionArray = [[NSArray alloc]initWithObjects:NSLocalizedString(@"STR_CONFIG", nil), nil];
}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setConfigSectionArray:nil];
    [self setConfigItemArray:nil];
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
