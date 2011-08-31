//
//  ISSwitchViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISSwitchViewController.h"

@implementation ISSwitchViewController

@synthesize isLiteViewController;
@synthesize isLiteConfigViewController;
@synthesize isLiteHelpViewController;

// Manual Codes Begins

- (void)dealloc 
{
    [isLiteViewController release];
    [isLiteHelpViewController release];
    [isLiteConfigViewController release];
    
    [super dealloc];
}

-(void) lazyLoadView:(NSInteger) viewTag
{
    DLog(@"Lazy load view: %d", viewTag);
    switch (viewTag) 
    {
        case TAG_LITE_VIEW:
        {
            if (nil == self.isLiteViewController)
            {
                ISLiteViewController *liteViewController = [[ISLiteViewController alloc] initWithNibName:@"ISLiteViewController" bundle:nil];
                [liteViewController.view setTag:TAG_LITE_VIEW];
                self.isLiteViewController = liteViewController;
                [liteViewController release];
                DLog(@"View: %d and its controller are initialized", viewTag);
            }
            [self.view addSubview:self.isLiteViewController.view];
            DLog(@"View: %d is on the top now.", viewTag);
            break;
        }
        case TAG_LITEHELP_VIEW:
        {
            if (nil == self.isLiteHelpViewController)
            {
                ISLiteHelpViewController *helpViewController = [[ISLiteHelpViewController alloc] initWithNibName:@"ISLiteHelpViewController" bundle:nil];
                [helpViewController.view setTag:TAG_LITEHELP_VIEW];
                self.isLiteHelpViewController = helpViewController;
                [helpViewController release];
                DLog(@"View: %d and its controller are initialized", viewTag);
            }
            [self.view addSubview:self.isLiteHelpViewController.view];
            DLog(@"View: %d is on the top now.", viewTag);        
            break;
        }
        case TAG_LITECONFIG_VIEW:
        {
            if (nil == self.isLiteConfigViewController)
            {
                ISLiteConfigViewController *configViewController = [[ISLiteConfigViewController alloc] initWithNibName:@"ISLiteConfigViewController" bundle:nil];
                [configViewController.view setTag:TAG_LITECONFIG_VIEW];
                self.isLiteConfigViewController = configViewController;
                [configViewController release];
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
        case TAG_LITE_VIEW:
        {
            [self lazyLoadView:TAG_LITE_VIEW];
            [self reorganizeSubViews:TAG_LITE_VIEW];
            break;
        }
        case TAG_LITEHELP_VIEW:
        {
            [self lazyLoadView:TAG_LITEHELP_VIEW];
            [self reorganizeSubViews:TAG_LITEHELP_VIEW];
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
    [self lazyLoadView:TAG_LITE_VIEW];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setIsLiteViewController:nil];
    [self setIsLiteHelpViewController:nil];
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
