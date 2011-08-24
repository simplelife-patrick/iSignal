//
//  ISLiteHelpViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISLiteHelpViewController.h"

#import "SwitchViewController.h"

@implementation ISLiteHelpViewController

// Manual Codes Begin

@synthesize backButton;

- (void)dealloc 
{
    [backButton release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)switchToLiteView:(id)sender
{
    UIViewController* parentViewController = [ISUIUtils getViewControllerFromView:[self.view superview]];
    if([parentViewController isKindOfClass:[SwitchViewController class]])
    {
        [((SwitchViewController*)parentViewController) switchView:TAG_LITE_VIEW];
    }  
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
