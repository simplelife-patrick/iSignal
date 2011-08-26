//
//  SplashViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-26.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

// Manual Codes Begin

@synthesize switchViewController;
@synthesize splashImageView;
@synthesize timer;

- (void)dealloc
{
    [self.timer release];
    [self.switchViewController release];
    [self.splashImageView release];
    
    [super dealloc];
}

- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}


- (void) finishedFading
{
	[splashImageView removeFromSuperview];
    UIWindow* window = [ISUIUtils getWindow:self.view];
    if(nil != window)
    {
        [self.view removeFromSuperview];
        [window addSubview:switchViewController.view];
    }
}

- (void) loadAnyNecessaryStuff
{
    DLog(@"Start to load anything necessary for this app.");
    // TODO:
    DLog(@"Finished the load operation.");
    // Switch back to Splash UI
    [self performSelectorOnMainThread:@selector(fadeScreen) withObject:self waitUntilDone:NO];
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

    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loadAnyNecessaryStuff) userInfo:nil repeats:NO];
}

- (void)viewDidUnload
{
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
