//
//  SwitchViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "SwitchViewController.h"

#import "ISLiteViewController.h"
#import "ISLiteHelpViewController.h"
#import "ISLiteConfigViewController.h"

@implementation SwitchViewController

@synthesize isLiteViewController;
@synthesize isLiteConfigViewController;
@synthesize isLiteHelpViewController;

// Manual Codes Begins

-(void) lazyLoadView:(NSInteger) viewTag
{
    switch (viewTag) 
    {
        case TAG_LITEVIEW:
        {
            if (nil == self.isLiteViewController)
            {
                ISLiteViewController *liteViewController = [[ISLiteViewController alloc] initWithNibName:@"ISLiteViewController" bundle:nil];
                [liteViewController.view setTag:TAG_LITEVIEW];
                self.isLiteViewController = liteViewController;
                [liteViewController release];
            }
            [self.view addSubview:self.isLiteViewController.view];
            
            break;
        }
        case TAG_LITEHELPVIEW:
        {
            if (nil == self.isLiteHelpViewController)
            {
                ISLiteHelpViewController *helpViewController = [[ISLiteHelpViewController alloc] initWithNibName:@"ISLiteHelpViewController" bundle:nil];
                [helpViewController.view setTag:TAG_LITEHELPVIEW];
                self.isLiteHelpViewController = helpViewController;
                [helpViewController release];
            }
            [self.view addSubview:self.isLiteHelpViewController.view];
            
            break;
        }
        case TAG_LITECONFIGVIEW:
        {
            if (nil == self.isLiteConfigViewController)
            {
                ISLiteConfigViewController *configViewController = [[ISLiteConfigViewController alloc] initWithNibName:@"ISLiteConfigViewController" bundle:nil];
                [configViewController.view setTag:TAG_LITECONFIGVIEW];
                self.isLiteConfigViewController = configViewController;
                [configViewController release];
            }
            [self.view addSubview:self.isLiteConfigViewController.view];                

            break;
        }
        default:
        {
            break;
        }
    }    
}

-(void) reorganizeSubView:(NSInteger) exceptViewTag
{
    NSArray *subViews = [self.view subviews];
    UIView *exceptView = nil;
    for (id obj in subViews) 
    {
        UIView *subView = (UIView*) obj;
        if(exceptViewTag != [subView tag])
        {
            [subView removeFromSuperview];
        }
        else
        {
            exceptView = subView;
        }
    }
    
    if(nil != exceptView)
    {
        if (nil == exceptView.superview) 
        {
            [self.view addSubview:exceptView];
        }
        [self.view bringSubviewToFront:exceptView];
    }
}

-(void) switchView:(NSInteger) viewTag
{
    switch (viewTag) 
    {
        case TAG_LITEVIEW:
        {
            [self lazyLoadView:TAG_LITEVIEW];
            [self reorganizeSubView:TAG_LITEVIEW];
            break;
        }
        case TAG_LITEHELPVIEW:
        {
            [self lazyLoadView:TAG_LITEHELPVIEW];
            [self reorganizeSubView:TAG_LITEHELPVIEW];
            break;
        }
        case TAG_LITECONFIGVIEW:
        {
            [self lazyLoadView:TAG_LITECONFIGVIEW];
            [self reorganizeSubView:TAG_LITECONFIGVIEW];
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
    [self lazyLoadView:TAG_LITEVIEW];
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

- (void)dealloc {
    [isLiteViewController release];
    [isLiteHelpViewController release];
    [isLiteConfigViewController release];
    [super dealloc];
}

@end
