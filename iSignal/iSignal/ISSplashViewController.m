//
//  ISSplashViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-26.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISSplashViewController.h"

@implementation ISSplashViewController

// Manual Codes Begin

@synthesize switchViewController;
@synthesize progressLabel;
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Init timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loadAnyNecessaryStuff) userInfo:nil repeats:NO];
}

- (void)viewDidUnload
{
    [self setTimer:nil];
    [self setProgressLabel:nil];
    [self setSwitchViewController:nil];
    [super viewDidUnload];
}

- (void)dealloc
{   
    [switchViewController release];
    [progressLabel release];
    [timer release];
    
    [super dealloc];
}

- (void)startFadingSplashScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishFadingSplashScreen)];   // calls the finishFadingSplashScreen method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}

- (void) finishFadingSplashScreen
{
    UIWindow* window = [CBUIUtils getWindow:self.view];
    if(nil != window)
    {
        [self.view removeFromSuperview];
        [window addSubview:switchViewController.view];
    }
}

- (void) loadAnyNecessaryStuff
{
    // All CBModules should start here    
    DLog(@"Start to load anything necessary for this app.");
    
    // App Configs module start
    [ISAppConfigs initConfigsIfNecessary];
        
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    
    // Location module start
    // TODO: Location module should not be inited if location service is not supported or disabled currently.
    CBLocationManager *cbLocationM = [[CBLocationManager alloc] initWithIsIndividualThreadNecessary: TRUE];
    appDelegate.locationModule = cbLocationM;
    if ([ISAppConfigs isLocationOn])
    {
        [appDelegate.locationModule initModule];
        [appDelegate.locationModule startService];
    }
    [cbLocationM release];
    
    // CoreData module start
    ISCoreDataModule *isCoreDataM = [[ISCoreDataModule alloc] init];
    appDelegate.coreDataModule = isCoreDataM;
    [appDelegate.coreDataModule initModule];
    [appDelegate.coreDataModule startService];
    [isCoreDataM release];
    
    // Audio module start
    ISAudioModule *isAM = [[ISAudioModule alloc] init];
    appDelegate.audioModule = isAM;
    [appDelegate.audioModule initModule];
    [appDelegate.audioModule startService];
    [isAM release];
    
    // ISDummyTelephony module start
    ISDummyTelephonyModule *isDummyT = [[ISDummyTelephonyModule alloc] initWithIsIndividualThreadNecessary: TRUE];
    appDelegate.dummyTelephonyModule = isDummyT;
    [appDelegate.dummyTelephonyModule initModule];
    [appDelegate.dummyTelephonyModule startService]; 
    [isDummyT release];
    
    DLog(@"Finished the modules load operation.");
    // Switch back to Splash UI
    [self performSelectorOnMainThread:@selector(startFadingSplashScreen) withObject:self waitUntilDone:NO];
}

-(void) updateProgress:(NSString*) progress
{
    [self.progressLabel setText:progress];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
