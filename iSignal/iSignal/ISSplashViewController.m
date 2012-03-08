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
@synthesize progressView;
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loadAnyNecessaryStuff) userInfo:nil repeats:NO];
}

- (void)viewDidUnload
{
    [self setTimer:nil];
    [self setProgressLabel:nil];
    [self setSwitchViewController:nil];
    [self setProgressView:nil];
    [super viewDidUnload];
}

- (void)dealloc
{   
    [switchViewController release];
    [progressLabel release];
    [timer release];
    
    [progressView release];
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
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    
    [self updateProgress:MODULE_IDENTITY_APP_CONFIGS andPercents:0.2];
    [ISAppConfigs initConfigsIfNecessary];
    
    // Location module start
    // TODO: Location module should not be inited if location service is not supported or disabled currently.
    [self updateProgress:MODULE_IDENTITY_LOCATION_MANAGER andPercents:0.4];    
    CBLocationManager *cbLocationM = [[CBLocationManager alloc] initWithIsIndividualThreadNecessary: TRUE];
    appDelegate.locationModule = cbLocationM;
    if ([ISAppConfigs isLocationOn])
    {
        [appDelegate.locationModule initModule];
        [appDelegate.locationModule startService];
    }
    [cbLocationM release];
    
    // CoreData module start
    [self updateProgress:MODULE_ID_COREDATA andPercents:0.6];
    ISCoreDataModule *isCoreDataM = [[ISCoreDataModule alloc] init];
    appDelegate.coreDataModule = isCoreDataM;
    [appDelegate.coreDataModule initModule];
    [appDelegate.coreDataModule startService];
    [isCoreDataM release];
    
    // Audio module start
    [self updateProgress:MODULE_IDENTITY_AUDIO_MODULE andPercents:0.8];
    ISAudioModule *isAM = [[ISAudioModule alloc] init];
    appDelegate.audioModule = isAM;
    [appDelegate.audioModule initModule];
    [appDelegate.audioModule startService];
    [isAM release];
    
    // ISDummyTelephony module start 
    [self updateProgress:MODULE_ID_DUMMYTEPLEPHONY andPercents:0.9];    
    ISDummyTelephonyModule *isDummyT = [[ISDummyTelephonyModule alloc] initWithIsIndividualThreadNecessary: TRUE];
    appDelegate.dummyTelephonyModule = isDummyT;
    [appDelegate.dummyTelephonyModule initModule];
    // Start this module after all UI loading done.
    // [appDelegate.dummyTelephonyModule startService]; 
    [isDummyT release];
    
    // ISUILocalNotification module start
    [self updateProgress:MODULE_IDENTITY_UILOCALNOTIFICATION_MODULE andPercents:1.0];
    ISUILocalNotificationModule *isULNM = [[ISUILocalNotificationModule alloc] initWithIsIndividualThreadNecessary: FALSE];
    appDelegate.uiLocalNotificationModule = isULNM;
    [appDelegate.uiLocalNotificationModule initModule];
    [appDelegate.uiLocalNotificationModule startService];
    [isULNM release];
    
    DLog(@"Finished the modules load operation.");
    // Switch back to Splash UI
    [self performSelectorOnMainThread:@selector(startFadingSplashScreen) withObject:self waitUntilDone:YES];
}

-(void) updateProgress:(NSString*) text andPercents:(float) percents 
{
    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate distantPast]];  
    [self performSelectorOnMainThread:@selector(updateProgressText:) withObject:text waitUntilDone:NO];
    NSNumber *percentsVal = [NSNumber numberWithFloat:percents];
    [self performSelectorOnMainThread:@selector(updateProgressPercents:) withObject:percentsVal waitUntilDone:NO];        
}

-(void) updateProgressText:(NSString*) text
{
    if ([self.progressLabel isHidden]) 
    {
        [self.progressLabel setHidden:FALSE];
    }
    
    text = (nil != text) ? text : @"Loading...";
    [self.progressLabel setText:text];
}

-(void) updateProgressPercents:(NSNumber*) percentsVal
{
    if ([self.progressView isHidden]) 
    {
        [self.progressView setHidden:FALSE];
    }
    
    [self.progressView setProgress:percentsVal.floatValue animated:TRUE];    
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
