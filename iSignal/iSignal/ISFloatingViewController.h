//
//  ISFloatingViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISSwitchViewController.h"

@interface ISFloatingViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *toggleButton;
@property (nonatomic, retain) IBOutlet UIButton *homeButton;
@property (nonatomic, retain) IBOutlet UIButton *recordsButton;
@property (nonatomic, retain) IBOutlet UIButton *mapButton;
@property (nonatomic, retain) IBOutlet UIButton *configButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;

@property (nonatomic) BOOL isViewRected;

@property (nonatomic) CGRect retractRect;
@property (nonatomic) CGRect popupRect;

- (IBAction)onToggle:(id)sender;
- (IBAction)onHome:(id)sender;
- (IBAction)onRecords:(id)sender;
- (IBAction)onMap:(id)sender;
- (IBAction)onConfig:(id)sender;
- (IBAction)onHelp:(id)sender;



@end
