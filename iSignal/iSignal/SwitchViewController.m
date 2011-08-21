//
//  SwitchViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "SwitchViewController.h"

#import "ISLiteViewController.h"
#import "ISLiteConfigViewController.h"
#import "ISLiteHelpViewController.h"

@implementation SwitchViewController

@synthesize isLiteViewController;
@synthesize isLiteConfigViewController;
@synthesize isLiteHelpViewController;

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
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ISLiteViewController *liteViewController = [[ISLiteViewController alloc] initWithNibName:@"ISLiteViewController" bundle:nil];
    self.isLiteViewController = liteViewController;
    [liteViewController release];
    
    // Below two view controllers shoud not be initialized here immediately, lazy-loading will be better.
    ISLiteHelpViewController *helpViewController = [[ISLiteHelpViewController alloc] initWithNibName:@"ISLiteHelpViewController" bundle:nil];
    self.isLiteHelpViewController = helpViewController;
    [helpViewController release];
    
    ISLiteConfigViewController *configViewController = [[ISLiteConfigViewController alloc] initWithNibName:@"ISLiteConfigViewController" bundle:nil];
    self.isLiteConfigViewController = configViewController;
    [configViewController release];
    
    [self.view insertSubview:self.isLiteViewController.view atIndex:2];
    [self.view insertSubview:self.isLiteHelpViewController.view atIndex:0];
    [self.view insertSubview:self.isLiteConfigViewController.view atIndex:1];
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

// Manual Codes
-(void) switchView:(id) sender andViewId:NSInteger
{
//    - (void) switchView {
//        if( self.foodlistController == nil ) {
//            FoodListController *fc = [[FoodListController alloc] initWithNibName:@"FoodListView" bundle:nil];
//            self.foodlistController = fc;
//            [fc release];
//        }
//        if( self.welcomeController.view.superview != nil ) {
//            [welcomeController.view removeFromSuperview];
//            [self.view insertSubview:foodlistController.view atIndex:0];
//        }
//        else {
//            [foodlistController.view removeFromSuperview];
//            [self.view insertSubview:welcomeController.view atIndex:0];
//        }
//    }
}

@end
