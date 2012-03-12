//
//  ISSwitchViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISSwitchViewController.h"

@implementation ISSwitchViewController

@synthesize homeViewController;

@synthesize recordsViewController;
@synthesize recordsViewNavigationController;

@synthesize mapViewController;
@synthesize mapViewNavigationController;

@synthesize monitorViewController;

@synthesize configViewController;

@synthesize helpViewController;

// Manual Codes Begins

- (void)dealloc 
{
    [homeViewController release];

    [recordsViewController release];    
    [recordsViewNavigationController release];
    
    [mapViewController release];
    [mapViewNavigationController release];
    
    [monitorViewController release];

    [configViewController release];
    
    [helpViewController release];

    [super dealloc];
}

- (void)loadTabViews
{
    ISHomeViewController *isHomeVC = [[ISHomeViewController alloc] initWithNibName:NIB_HOMEVIEW_CONTROLLER bundle:nil];
    self.homeViewController = isHomeVC;
    [isHomeVC release];
    
    ISRecordsViewController *isRecordVC = [[ISRecordsViewController alloc] initWithNibName:NIB_RECORDSVIEW_CONTROLLER bundle:nil];
    self.recordsViewController = isRecordVC;
    [isRecordVC release];
    
    ISRecordsViewNavigationController *isRVNC = [[ISRecordsViewNavigationController alloc] initWithRootViewController: self.recordsViewController];
    self.recordsViewNavigationController = isRVNC;
    [isRVNC release];    
    
    ISMapViewController *isMapVC = [[ISMapViewController alloc] initWithNibName:NIB_MAPVIEW_CONTROLLER bundle:nil];
    self.mapViewController = isMapVC;
    [isMapVC release];
    
    ISMapViewNavigationController *isMVNC = [[ISMapViewNavigationController alloc] initWithRootViewController:self.mapViewController];
    self.mapViewNavigationController = isMVNC;
    [isMVNC release];
    
    ISMonitorViewController *isMonVC = [[ISMonitorViewController alloc] initWithNibName:NIB_MONITORVIEW_CONTROLLER bundle:nil];
    self.monitorViewController = isMonVC;
    [isMonVC release];
    
    ISConfigViewController *isConfigVC = [[ISConfigViewController alloc] initWithNibName:NIB_CONFIGVIEW_CONTROLLER bundle:nil];
    self.configViewController = isConfigVC;
    [isConfigVC release];  
    
    ISHelpViewController *isHelpVC = [[ISHelpViewController alloc] initWithNibName:NIB_HELPVIEW_CONTROLLER bundle:nil];
    self.helpViewController = isHelpVC;
    [isHelpVC release];
    
    [self setViewControllers:[NSArray arrayWithObjects:self.homeViewController, self.recordsViewNavigationController, self.mapViewNavigationController,self.configViewController, self.helpViewController, nil] animated:FALSE];

    [self setSelectedViewController:homeViewController];
    
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    [appDelegate.dummyTelephonyModule startService];   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTabViews];
}

- (void)viewDidUnload
{
    [self setHomeViewController:nil];

    [self setRecordsViewController:nil];
    [self setRecordsViewNavigationController:nil];
    
    [self setMapViewController:nil];
    [self setMapViewNavigationController:nil];    
    
    [self setMonitorViewController:nil];    
    
    [self setConfigViewController:nil];    
    
    [self setHelpViewController:nil];
    
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

// Method of UITabBarControllerDelegate protocol
- (void) tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{

}

// Method of UITabBarControllerDelegate protocol
- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) 
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
    }    
}

// Method of UITabBarControllerDelegate protocol
- (void) tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{

}

// Method of UITabBarControllerDelegate protocol
- (void) tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{

}

// Manual Codes Ends

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
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
