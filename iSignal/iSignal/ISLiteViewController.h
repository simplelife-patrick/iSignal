//
//  ISLiteViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreFoundation/CoreFoundation.h>

#import "ISUIUtils.h"

#import "ISCallbackDelegate.h"
#import "ISDummyTelephony.h"
#import "ISTelephonyUtils.h"

@interface ISLiteViewController : UIViewController <ISCallbackDelegate>
{
    UIButton *helpButton;
    UIButton *configButton;
    UILabel *signLabel;
    UILabel *unitLabel;
    UILabel *carrierLabel;
    UILabel *signalStrengthLabel;
}

@property (nonatomic, retain) IBOutlet UIButton *configButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;
@property (nonatomic, retain) IBOutlet UILabel *signLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitLabel;
@property (nonatomic, retain) IBOutlet UILabel *carrierLabel;
@property (nonatomic, retain) IBOutlet UILabel *signalStrengthLabel;

-(IBAction) switchToHelpView:(id) sender;
-(IBAction) switchToConfigView:(id) sender;

-(void) updateSignalStrength:(NSNumber*) signalVal;
-(void) updateCarrier:(NSString*) carrierStr;

@end
