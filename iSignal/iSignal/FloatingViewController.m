//
//  ISFloatingViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "FloatingViewController.h"

@implementation FloatingViewController

// Manual Codes Begin

@synthesize toggleButton;
@synthesize isViewRected;

@synthesize retractRect;
@synthesize popupRect;

- (void)dealloc 
{
    [toggleButton release];
    [super dealloc];
}

-(IBAction)onToggle:(id)sender
{
    if(self.isViewRected)
    {
        DLog(@"Floating view is in rect state");
        self.view.frame = self.popupRect;
    }
    else
    {
        DLog(@"Floating view is in popup state");
        self.view.frame = self.retractRect;
    }
    
    self.isViewRected = !self.isViewRected;
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

- (void)viewDidUnload
{
    [self setToggleButton:nil];
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
