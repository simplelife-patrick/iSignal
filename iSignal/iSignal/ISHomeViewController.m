//
//  ISHomeViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#include <Foundation/Foundation.h>

#import "ISHomeViewController.h"

@implementation ISHomeViewController

// Manual Codes Begin

@synthesize gradeIndicator01View;
@synthesize gradeIndicator02View;
@synthesize gradeIndicator03View;
@synthesize gradeIndicator04View;
@synthesize gradeIndicator05View;

@synthesize signLabel;
@synthesize unitLabel;
@synthesize carrierLabel;
@synthesize signalStrengthLabel;
@synthesize noSignalView;
@synthesize qualityGradeLabel;

- (void)initTabBarItem
{
    UIImage* itemImage = [UIImage imageNamed:@"home32.png"];
//    UIImage* itemImage = nil;
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_HOME", nil) image:itemImage tag:TAG_HOMEVIEW];
    self.tabBarItem = theItem;
    [theItem release];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        [self initTabBarItem];
    }
    return self;
}

- (void)dealloc 
{
    [qualityGradeLabel release];
    [signLabel release];
    [unitLabel release];
    [carrierLabel release];
    [signalStrengthLabel release];

    [gradeIndicator01View release];
    [gradeIndicator02View release];
    [gradeIndicator03View release];
    [gradeIndicator04View release];
    [gradeIndicator05View release];
    
    [noSignalView release];
    
    [super dealloc];
}

-(void)updateSignalQualityGrade:(SIGNAL_QUALITY) quality
{
    BOOL b1 = FALSE;
    BOOL b2 = FALSE;
    BOOL b3 = FALSE;
    BOOL b4 = FALSE;
    BOOL b5 = FALSE;
    
    switch (quality) 
    {
        case QUALITY_SIGNAL_LOSS:
        {
            break;
        }
        case QUALITY_SIGNAL_1:
        {
            b1 = TRUE;
            break;
        }
        case QUALITY_SIGNAL_2:
        {
            b1 = TRUE;
            b2 = TRUE;
            break;
        }
        case QUALITY_SIGNAL_3:
        {
            b1 = TRUE;
            b2 = TRUE;
            b3 = TRUE;
            break;
        }
        case QUALITY_SIGNAL_4:
        {
            b1 = TRUE;
            b2 = TRUE;
            b3 = TRUE;            
            b4 = TRUE;
            break;
        }
        case QUALITY_SIGNAL_BEST:
        {
            b1 = TRUE;
            b2 = TRUE;
            b3 = TRUE;            
            b4 = TRUE;            
            b5 = TRUE;
            break;
        }
        default:
        {
            break;
        }
    }
    
    [self.gradeIndicator01View setHighlighted:b1];
    [self.gradeIndicator02View setHighlighted:b2];
    [self.gradeIndicator03View setHighlighted:b3];
    [self.gradeIndicator04View setHighlighted:b4];            
    [self.gradeIndicator05View setHighlighted:b5];     
}

-(void)updateSignalStrength:(NSNumber*) signalVal
{
    if (nil != signalVal)
    {
        NSInteger intVal = [signalVal intValue];
        NSString* strVal = [signalVal stringValue];
        SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
        if (qualityGrade == QUALITY_SIGNAL_LOSS) 
        {
            iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
            
            strVal = NSLocalizedString(@"STR_NOSIGNAL",nil);
            DLog(@"Translate received signal strength: %d to text: %@", intVal, strVal);
            
            // Ring
            BOOL ringAlarmOn = [ISAppConfigs isRingAlarmOn];
            if(ringAlarmOn)
            {
                [appDelegate.avModule playAudio];
            }

            // TODO: Should be moved to a single module            
            // Vibrate
            BOOL vibrateAlarmOn = [ISAppConfigs isVibrateAlarmOn];

            if(vibrateAlarmOn)
            {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);                
            }
            
            [self.signalStrengthLabel setHidden:TRUE];
            [self.noSignalView setHidden:FALSE];
        }
        else 
        {            
            [self.signalStrengthLabel setText:strVal];
            [self.signalStrengthLabel setHidden:FALSE];
            [self.noSignalView setHidden:TRUE];            
        }
    
        [self updateSignalQualityGrade:qualityGrade];
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

-(void) messageCallback:(id)message
{
//    DLog(@"CallbackDelegate(ISHomeViewController) received a message: %@", message);
    NSNumber *signalVal = (NSNumber*)message;
    [self performSelectorOnMainThread:@selector(updateSignalStrength:) withObject:(signalVal) waitUntilDone:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // TODO: Multiple delegates should be supported here as notification will be sent to places inlcuding UIView, Sounds and Vibration, etc.
    
    // Load data from ISDummyTelephony module
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    [appDelegate.dummyTelephonyModule registerDelegate:self]; // Register callback delegate to module

    [self updateCarrier:appDelegate.dummyTelephonyModule.carrier];
    [self.qualityGradeLabel setText:NSLocalizedString(@"STR_SIGNALGRADE", nil)];

    // The first received signal strength value is ahead of views' loading, in this case UI, CoreData will lost this value. Below lines are gonna fix this issue.
    NSInteger signalIntVal = appDelegate.dummyTelephonyModule.signalStrength;
    [self updateSignalStrength:[NSNumber numberWithInteger:signalIntVal]];
    [self updateSignalQualityGrade:signalIntVal];
}

- (void)viewDidUnload
{
    [self setSignLabel:nil];
    [self setUnitLabel:nil];
    [self setCarrierLabel:nil];
    [self setSignLabel:nil];
    [self setQualityGradeLabel:nil];

    [self setGradeIndicator01View:nil];
    [self setGradeIndicator02View:nil];
    [self setGradeIndicator03View:nil];
    [self setGradeIndicator04View:nil];
    [self setGradeIndicator05View:nil];
    [self setNoSignalView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Manual Codes End

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
