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


@interface ISSwitchViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet ISHomeViewController *homeViewController;

@property (nonatomic, retain) IBOutlet ISRecordsViewController *recordsViewController;
@property (nonatomic, retain) IBOutlet ISRecordsViewNavigationController *recordsViewNavigationController;

@property (nonatomic, retain) IBOutlet ISMonitorViewController *monitorViewController;

@property (nonatomic, retain) IBOutlet ISMapViewController *mapViewController;
@property (nonatomic, retain) IBOutlet ISMapViewNavigationController *mapViewNavigationController;

@property (nonatomic, retain) IBOutlet ISConfigViewController *configViewController;

@property (nonatomic, retain) IBOutlet ISHelpViewController *helpViewController;

- (void)loadTabViews;

@end
