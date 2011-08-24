//
//  ISLiteViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import "ISLiteViewController.h"
#import "SwitchViewController.h"

@implementation ISLiteViewController

// Manual Codes Begin

@synthesize configButton;
@synthesize helpButton;
@synthesize signLabel;
@synthesize unitLabel;
@synthesize carrierLabel;
@synthesize signalStrengthLabel;

- (void)dealloc 
{
    [helpButton release];
    [configButton release];
    [signLabel release];
    [unitLabel release];
    [carrierLabel release];
    [signalStrengthLabel release];
    [super dealloc];
}

-(void)updateSignalStrength:(NSInteger) signalVal
{
    NSString* signalText = [NSString stringWithFormat:@"%d", signalVal];
    [self.signalStrengthLabel setText:signalText];
    DLog(@"Label signalStrength is set to: %@", signalText);
}

-(void)updateCarrier:(NSString *)carrierStr
{
    [self.carrierLabel setText:carrierStr];
    DLog(@"Label carrier is set to: %@", carrierStr);
}

-(IBAction)switchToHelpView:(id)sender
{
    UIViewController* parentViewController = [ISUIUtils getViewControllerFromView:[self.view superview]];
    if([parentViewController isKindOfClass:[SwitchViewController class]])
    {
        [((SwitchViewController*)parentViewController) switchView:TAG_LITEHELP_VIEW];
    }
}

-(IBAction)switchToConfigView:(id)sender
{
    UIViewController* parentViewController = [ISUIUtils getViewControllerFromView:[self.view superview]];
    if([parentViewController isKindOfClass:[SwitchViewController class]])
    {
        [((SwitchViewController*)parentViewController) switchView:TAG_LITECONFIG_VIEW];
    }    
}

-(void) messageCallback:(id)message
{
    DLog(@"CallbackDelegate(ISLiteViewController) received a message: %@", message);
    NSNumber *signalVal = (NSNumber*)message;
    [self performSelectorOnMainThread:@selector(updateSignalStrength:) withObject:(signalVal) waitUntilDone:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // TODO: Multiple delegates should be supported here as notification will be sent to places inlcuding UIView, Sounds and Vibration, etc.
    ISDummyTelephony *dummyTelephony = [[ISDummyTelephony alloc] init];
    [dummyTelephony setCallbackDelegate:self];
    
    [self.carrierLabel setText:dummyTelephony.carrier];
    
    [dummyTelephony startToService];
    [dummyTelephony release];
}

- (void)viewDidUnload
{
    [self setHelpButton:nil];
    [self setConfigButton:nil];
    [self setSignLabel:nil];
    [self setUnitLabel:nil];
    [self setCarrierLabel:nil];
    [self setSignLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
