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
@synthesize isLiteConfigViewController;
@synthesize helpViewController;

// Manual Codes Begins

- (void)dealloc 
{
    [homeViewController release];
    [helpViewController release];
    [isLiteConfigViewController release];
    
    [super dealloc];
}

-(void) lazyLoadView:(NSInteger) viewTag
{
    DLog(@"Lazy load view: %d", viewTag);
    switch (viewTag) 
    {
        case TAG_HOMEVIEW:
        {
            if (nil == self.homeViewController)
            {
                ISHomeViewController *viewController = [[ISHomeViewController alloc] initWithNibName:@"ISLiteViewController" bundle:nil];
                [viewController.view setTag:TAG_HOMEVIEW];
                self.homeViewController = viewController;
                [viewController release];
                DLog(@"View: %d and its controller are initialized", viewTag);
            }
            [self.view addSubview:self.homeViewController.view];
            DLog(@"View: %d is on the top now.", viewTag);
            break;
        }
        case TAG_HELPVIEW:
        {
            if (nil == self.helpViewController)
            {
                ISHelpViewController *viewController = [[ISHelpViewController alloc] initWithNibName:@"ISHelpViewController" bundle:nil];
                [self.helpViewController.view setTag:TAG_HELPVIEW];
                self.helpViewController = viewController;
                [self.helpViewController release];
                DLog(@"View: %d and its controller are initialized", viewTag);
            }
            [self.view addSubview:self.helpViewController.view];
            DLog(@"View: %d is on the top now.", viewTag);        
            break;
        }
        case TAG_LITECONFIG_VIEW:
        {
            if (nil == self.isLiteConfigViewController)
            {
                ISLiteConfigViewController *viewController = [[ISLiteConfigViewController alloc] initWithNibName:@"ISLiteConfigViewController" bundle:nil];
                [viewController.view setTag:TAG_LITECONFIG_VIEW];
                self.isLiteConfigViewController = viewController;
                [viewController release];
                DLog(@"View: %d and its controller are initialized", viewTag);
            }
            [self.view addSubview:self.isLiteConfigViewController.view];
            DLog(@"View: %d is on the top now.", viewTag);
            break;
        }
        case TAG_LITEMAP_VIEW:
        {
            // TODO:
            break;
        }
        case TAG_LITERECORDS_VIEW:
        {
            // TODO:
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
    NSArray *subViews = [self.view subviews];
    UIView *exceptView = nil;
    for (id obj in subViews) 
    {
        UIView *subView = (UIView*) obj;
        NSInteger subViewTag = [subView tag];
        if(exceptViewTag != subViewTag)
        {
            [subView removeFromSuperview];
            DLog(@"Sub view: %d is removed from super view now.", subViewTag);
        }
        else
        {
            exceptView = subView;
        }
    }
    
    if(nil != exceptView)
    {
        NSInteger exceptViewTag = [exceptView tag];
        if (nil == exceptView.superview) 
        {
            [self.view addSubview:exceptView];
            DLog(@"Sub view: %d is added into super view now.", exceptViewTag);
        }
        [self.view bringSubviewToFront:exceptView];
        DLog(@"Sub view: %d is moved to front now.", exceptViewTag);
    }
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
        case TAG_LITECONFIG_VIEW:
        {
            [self lazyLoadView:TAG_LITECONFIG_VIEW];
            [self reorganizeSubViews:TAG_LITECONFIG_VIEW];
            break;
        }
        case TAG_LITEMAP_VIEW:
        {
            [self lazyLoadView:TAG_LITEMAP_VIEW];
            [self reorganizeSubViews:TAG_LITEMAP_VIEW];
            break;
        }
        case TAG_LITERECORDS_VIEW:
        {
            [self lazyLoadView:TAG_LITERECORDS_VIEW];
            [self reorganizeSubViews:TAG_LITERECORDS_VIEW];
            break;
        }
        default:
        {
            break;
        }
    }
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
    [self setIsLiteConfigViewController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
