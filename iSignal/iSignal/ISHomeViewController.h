//
//  ISHomeViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreFoundation/CoreFoundation.h>

#import "CBUIUtils.h"

#import "ISDummyTelephonyModule.h"
#import "CBTelephonyUtils.h"
#import "CBLocationManager.h"

#import "ISSwitchViewController.h"

@interface ISHomeViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *gradeIndicator01View;
@property (nonatomic, retain) IBOutlet UIImageView *gradeIndicator02View;
@property (nonatomic, retain) IBOutlet UIImageView *gradeIndicator03View;
@property (nonatomic, retain) IBOutlet UIImageView *gradeIndicator04View;
@property (nonatomic, retain) IBOutlet UIImageView *gradeIndicator05View;

@property (nonatomic, retain) IBOutlet UILabel *qualityGradeLabel;
@property (nonatomic, retain) IBOutlet UILabel *signLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitLabel;
@property (nonatomic, retain) IBOutlet UILabel *carrierLabel;
@property (nonatomic, retain) IBOutlet UILabel *signalStrengthLabel;

@property (nonatomic, retain) IBOutlet UIImageView *noSignalView;


-(void) updateSignalStrength:(NSNumber*) signalVal;
-(void) updateCarrier:(NSString*) carrierStr;

@end
