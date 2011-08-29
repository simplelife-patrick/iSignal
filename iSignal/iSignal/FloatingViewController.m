//
//  FloatingViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "FloatingViewController.h"

@implementation FloatingViewController

// Manual Codes Begin

+(void) initialize
{    
    s_viewLocation_retract = CGPointMake(POINT_X_RETRACT, POINT_Y_RETRACT);    
    s_viewLocation_popup = CGPointMake(POINT_X_POPUP, POINT_Y_POPUP);

    s_viewSize_normal = CGSizeMake(SIZE_WIDTH_NORAML, SIZE_HEIGHT_NORMAL);
}

@synthesize toggleButton;

- (void)dealloc 
{
    [toggleButton release];
    [super dealloc];
}

-(IBAction)onToggle:(id)sender
{
    
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
