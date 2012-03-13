//
//  ISMonitorViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-12.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISMonitorViewController.h"

@implementation ISMonitorViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
