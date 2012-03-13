//
//  ISHomeViewController.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

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
    UIImage* itemImage = [UIImage imageNamed:@"tab_home.png"];
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_HOME", nil) image:itemImage tag:TABVIEW_INDEX_HOMEVIEW];
    self.tabBarItem = theItem;
    [theItem release];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
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
        case QUALITY_SIGNAL_NO:
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
        if (qualityGrade == QUALITY_SIGNAL_NO) 
        {
            strVal = NSLocalizedString(@"STR_NOSIGNAL",nil);
            DLog(@"Translate received signal strength: %d to text: %@", intVal, strVal);
            
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self listenSignalStrengthChanged];

    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];
    [self updateCarrier:appDelegate.dummyTelephonyModule.carrier];
    [self.qualityGradeLabel setText:NSLocalizedString(@"STR_SIGNALGRADE", nil)];
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
}

// Private Method
-(void) listenSignalStrengthChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSignalStrengthChanged:) name:
     NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:nil];      
}

// Private Method
-(void) onSignalStrengthChanged:(NSNotification *) notification
{
    NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
    NSNumber *signalVal = (NSNumber*)nsValue;
    [self performSelectorOnMainThread:@selector(updateSignalStrength:) withObject:(signalVal) waitUntilDone:NO];
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
