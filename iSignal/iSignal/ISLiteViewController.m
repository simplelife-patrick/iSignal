//
//  ISLiteViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#include <Foundation/Foundation.h>

#import "ISLiteViewController.h"
#import "SwitchViewController.h"

@implementation ISLiteViewController

// Manual Codes Begin

@synthesize qualityGradeLabel;
@synthesize configButton;
@synthesize helpButton;
@synthesize signLabel;
@synthesize unitLabel;
@synthesize carrierLabel;
@synthesize signalStrengthLabel;

@synthesize audioPlayer;

- (void)dealloc 
{
    [helpButton release];
    [configButton release];
    [signLabel release];
    [unitLabel release];
    [carrierLabel release];
    [signalStrengthLabel release];
    [audioPlayer release];
    [qualityGradeLabel release];
    [super dealloc];
}

-(void)updateSignalStrength:(NSNumber*) signalVal
{
    if (nil != signalVal)
    {
        NSInteger intVal = [signalVal intValue];
        NSString* strVal = [signalVal stringValue];
        SIGNAL_QUALITY qualityGrade = [ISTelephonyUtils evaluateSignalQuality:intVal];
        if (qualityGrade == QUALITY_SIGNAL_LOSS) 
        {
            strVal = NSLocalizedString(@"STR_NOSIGNAL",nil);
            DLog(@"Translate received signal strength: %d to text: %@", intVal, strVal);
            
            [self.audioPlayer play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        [self.signalStrengthLabel setText:strVal];
        DLog(@"Finish to set Label signalStrength to %@", strVal);
    }
    else
    {
        DLog(@"Can not set Label signalStrength to nil.");
    }
}

-(void)updateCarrier:(NSString *)carrierStr
{
    if (nil != carrierStr)
    {
        [self.carrierLabel setText:carrierStr];
        DLog(@"Label carrier is set to: %@", carrierStr);
    }
    else
    {
        DLog(@"Can not set Label carrier to nil.");
    }
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
    DLog(@"Message is casted to: %@", signalVal);
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
    
    [self.qualityGradeLabel setText:NSLocalizedString(@"STR_SIGNALGRADE", nil)];
    
    [dummyTelephony startToService];
    [dummyTelephony release];
    
    if (audioPlayer) 
    { 
        [audioPlayer release]; 
    }
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:@"knockx3" ofType:@"mp3"]; 
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath]; 
    audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    [audioPlayer prepareToPlay]; 
    [soundUrl release];     
}

- (void)viewDidUnload
{
    [self setHelpButton:nil];
    [self setConfigButton:nil];
    [self setSignLabel:nil];
    [self setUnitLabel:nil];
    [self setCarrierLabel:nil];
    [self setSignLabel:nil];
    [self setAudioPlayer:nil];
    [self setQualityGradeLabel:nil];
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
