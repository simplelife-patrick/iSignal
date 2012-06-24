//
//  ISMonitorViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-12.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISMonitorViewController.h"

@implementation ISMonitorViewController

@dynamic detailItem;
@synthesize hostingView;

- (void)initTabBarItem
{
    UIImage* itemImage = [UIImage imageNamed:@"tab_monitor.png"];
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_MONITOR", nil) image:itemImage tag:TABVIEW_INDEX_MONITORVIEW];
    self.tabBarItem = theItem;
    [theItem release];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        [self initTabBarItem];

    }
    return self;
}

- (void)dealloc
{
    [detailItem release];
    [hostingView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    ISSignalStrengthRealTimePlot *signalStrengthPlot = [[ISSignalStrengthRealTimePlot alloc] init];
    [self setDetailItem:signalStrengthPlot];
    [signalStrengthPlot release];
    
//    ISSimpleScatterPlot *simplePlot = [[ISSimpleScatterPlot alloc] init];
//    [self setDetailItem:simplePlot];
//    [simplePlot release];
}

- (void)viewDidUnload
{
    detailItem = nil;
    hostingView = nil;    
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CBPlotItem *)detailItem
{
	return self.detailItem;
}

-(void)setDetailItem:(id)newDetailItem
{
	if (detailItem != newDetailItem) 
    {
		[detailItem killGraph];
		[detailItem release];
        
		detailItem = [newDetailItem retain];
        //TODO: deal with the temp theme.
        CPTTheme *theme = [[ISMonitorScatterPlotTheme alloc] init];
        [detailItem renderInView:hostingView withTheme:theme];
        [theme release];
	}
}

@end
