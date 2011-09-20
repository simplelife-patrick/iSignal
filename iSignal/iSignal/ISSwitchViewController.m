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
@synthesize configViewController;
@synthesize mapViewController;
@synthesize recordsViewController;
@synthesize helpViewController;

// Manual Codes Begins

- (void)dealloc 
{
    [homeViewController release];
    [helpViewController release];
    [configViewController release];
    [mapViewController release];
    [recordsViewController release];
    [super dealloc];
}

-(void) lazyLoadView:(NSInteger) viewTag
{
    switch (viewTag) 
    {
        case TAG_HOMEVIEW:
        {
            if (nil == self.homeViewController)
            {
                ISHomeViewController *viewController = [[ISHomeViewController alloc] initWithNibName:NIB_HOMEVIEW_CONTROLLER bundle:nil];
                [viewController.view setTag:TAG_HOMEVIEW];
                self.homeViewController = viewController;
                [viewController release];
            }
            [self.view addSubview:self.homeViewController.view];
            break;
        }
        case TAG_HELPVIEW:
        {
            if (nil == self.helpViewController)
            {
                ISHelpViewController *viewController = [[ISHelpViewController alloc] initWithNibName:NIB_HELPVIEW_CONTROLLER bundle:nil];
                [viewController.view setTag:TAG_HELPVIEW];
                self.helpViewController = viewController;
                [self.helpViewController release];
            }
            [self.view addSubview:self.helpViewController.view];      
            break;
        }
        case TAG_CONFIGVIEW:
        {
            if (nil == self.configViewController)
            {
                ISConfigViewController *viewController = [[ISConfigViewController alloc] initWithNibName:NIB_CONFIGVIEW_CONTROLLER bundle:nil];
                [viewController.view setTag:TAG_CONFIGVIEW];
                self.configViewController = viewController;
                [viewController release];
            }
            [self.view addSubview:self.configViewController.view];
            break;
        }
        case TAG_MAPVIEW:
        {
            if (nil == self.mapViewController)
            {
                ISMapViewController *viewController = [[ISMapViewController alloc] initWithNibName:NIB_MAPVIEW_CONTROLLER bundle:nil];
                [viewController.view setTag:TAG_MAPVIEW];
                self.mapViewController = viewController;
                [viewController release];
            }
            [self.view addSubview:self.mapViewController.view];
            break;
        }
        case TAG_RECORDSVIEW:
        {
            if (nil == self.recordsViewController)
            {
                ISRecordsViewController *viewController = [[ISRecordsViewController alloc] initWithNibName:NIB_RECORDSVIEW_CONTROLLER bundle:nil];
                [viewController.view setTag:TAG_RECORDSVIEW];
                self.recordsViewController = viewController;
                [viewController release];
            }
            [self.view addSubview:self.recordsViewController.view];
            break;
        }
        default:
        {
            break;
        }
    }    
}

-(void) reorganizeSubViews:(NSInteger) exceptViewTag
{
//    NSArray *subViews = [self.view subviews];
//    UIView *exceptView = nil;
//    for (id obj in subViews) 
//    {
//        UIView *subView = (UIView*) obj;
//        NSInteger subViewTag = [subView tag];
//        if(exceptViewTag != subViewTag)
//        {
//            [subView removeFromSuperview];
//        }
//        else
//        {
//            exceptView = subView;
//        }
//    }
//    
//    if(nil != exceptView)
//    {
//        if (nil == exceptView.superview) 
//        {
//            [self.view addSubview:exceptView];
//        }
//        [self.view bringSubviewToFront:exceptView];
//    }
}

-(void) switchView:(NSInteger) viewTag
{
    switch (viewTag) 
    {
        case TAG_HOMEVIEW:
        {
            [self lazyLoadView:TAG_HOMEVIEW];
            [self reorganizeSubViews:TAG_HOMEVIEW];
            break;
        }
        case TAG_HELPVIEW:
        {
            [self lazyLoadView:TAG_HELPVIEW];
            [self reorganizeSubViews:TAG_HELPVIEW];
            break;
        }
        case TAG_CONFIGVIEW:
        {
            [self lazyLoadView:TAG_CONFIGVIEW];
            [self reorganizeSubViews:TAG_CONFIGVIEW];
            break;
        }
        case TAG_MAPVIEW:
        {
            [self lazyLoadView:TAG_MAPVIEW];
            [self reorganizeSubViews:TAG_MAPVIEW];
            break;
        }
        case TAG_RECORDSVIEW:
        {
            [self lazyLoadView:TAG_RECORDSVIEW];
            [self reorganizeSubViews:TAG_RECORDSVIEW];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    [self lazyLoadView:TAG_HOMEVIEW];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setHomeViewController:nil];
    [self setHelpViewController:nil];
    [self setConfigViewController:nil];
    [self setMapViewController:nil];
    [self setRecordsViewController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Manual Codes Ends

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
