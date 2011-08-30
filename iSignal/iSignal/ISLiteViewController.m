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

@synthesize gradeIndicator01View;
@synthesize gradeIndicator02View;
@synthesize gradeIndicator03View;
@synthesize gradeIndicator04View;
@synthesize gradeIndicator05View;

@synthesize signLabel;
@synthesize unitLabel;
@synthesize carrierLabel;
@synthesize signalStrengthLabel;
@synthesize qualityGradeLabel;

@synthesize audioPlayer;

- (void)dealloc 
{
    [qualityGradeLabel release];
    [signLabel release];
    [unitLabel release];
    [carrierLabel release];
    [signalStrengthLabel release];
    
    [audioPlayer release];
 
    [gradeIndicator01View release];
    [gradeIndicator02View release];
    [gradeIndicator03View release];
    [gradeIndicator04View release];
    [gradeIndicator05View release];
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
        SIGNAL_QUALITY qualityGrade = [ISTelephonyUtils evaluateSignalQuality:intVal];
        if (qualityGrade == QUALITY_SIGNAL_LOSS) 
        {
            strVal = NSLocalizedString(@"STR_NOSIGNAL",nil);
            DLog(@"Translate received signal strength: %d to text: %@", intVal, strVal);
            
            // TODO: Here should be different listeners which are used to observer signal changed.
            BOOL ringAlarmOn = [ISAppConfigs isRingAlarmOn];
            DLog(@"App config of ring alarm is %@.", ringAlarmOn?@"YES":@"NO");
            if(ringAlarmOn)
            {
                [self.audioPlayer play];                
            }
            
            BOOL vibrateAlarmOn = [ISAppConfigs isVibrateAlarmOn];
            DLog(@"App config of vibrate alarm is %@.", vibrateAlarmOn?@"YES":@"NO"); 
            if(vibrateAlarmOn)
            {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);                
            }
        }
        [self updateSignalQualityGrade:qualityGrade];
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
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:@"signalLost" ofType:@"caf"]; 
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath]; 
    audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    [audioPlayer prepareToPlay]; 
    [soundUrl release];     
}

- (void)viewDidUnload
{
    [self setSignLabel:nil];
    [self setUnitLabel:nil];
    [self setCarrierLabel:nil];
    [self setSignLabel:nil];
    [self setQualityGradeLabel:nil];

    [self setAudioPlayer:nil];
    
    [self setGradeIndicator01View:nil];
    [self setGradeIndicator02View:nil];
    [self setGradeIndicator03View:nil];
    [self setGradeIndicator04View:nil];
    [self setGradeIndicator05View:nil];
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
