//
//  ISSplashViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-26.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISSwitchViewController.h"

#import "CBFetchedResultsControllerIdentifier.h"

#define PROGRESS_STR_LOADING @"Loading..."

@interface ISSplashViewController : UIViewController

@property (nonatomic, retain) IBOutlet ISSwitchViewController *switchViewController;

@property (nonatomic, retain) IBOutlet UILabel *progressLabel;

@property (nonatomic, retain) NSTimer *timer;

-(void) loadAnyNecessaryStuff;

-(void) updateProgress:(NSString*) progress;

@end