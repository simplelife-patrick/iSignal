//
//  ISSwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISHomeViewController.h"

#import "ISRecordsViewController.h"
#import "ISRecordsViewNavigationController.h"

#import "ISMapViewController.h"
#import "ISMapViewNavigationController.h"

#import "ISMonitorViewController.h"

#import "ISConfigViewController.h"

#import "ISHelpViewController.h"
#import "ISHelpViewNavigationController.h"

@interface ISSwitchViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, retain) ISHomeViewController *homeViewController;

@property (nonatomic, retain) ISRecordsViewController *recordsViewController;
@property (nonatomic, retain) ISRecordsViewNavigationController *recordsViewNavigationController;

@property (nonatomic, retain) ISMonitorViewController *monitorViewController;

@property (nonatomic, retain) ISMapViewController *mapViewController;
@property (nonatomic, retain) ISMapViewNavigationController *mapViewNavigationController;

@property (nonatomic, retain) ISConfigViewController *configViewController;

@property (nonatomic, retain) ISHelpViewController *helpViewController;
@property (nonatomic, retain) ISHelpViewNavigationController *helpViewNavigationController;

- (void)loadTabViews;

@end
