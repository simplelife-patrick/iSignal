//
//  ISSwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISHomeViewController.h"
#import "ISHelpViewController.h"
#import "ISConfigViewController.h"
#import "ISMapViewController.h"
#import "ISRecordsViewController.h"

#define TAG_SWITCHVIEW 0
#define TAG_HOMEVIEW 1
#define TAG_HELPVIEW 2
#define TAG_CONFIGVIEW 3
#define TAG_MAPVIEW 4
#define TAG_RECORDSVIEW 5
#define TAG_COUNT_VIEWS 5

#define NIB_HOMEVIEW_CONTROLLER @"ISHomeViewController"
#define NIB_HELPVIEW_CONTROLLER @"ISHelpViewController"
#define NIB_CONFIGVIEW_CONTROLLER @"ISConfigViewController"
#define NIB_MAPVIEW_CONTROLLER @"ISMapViewController"
#define NIB_RECORDSVIEW_CONTROLLER @"ISRecordsViewController"

@interface ISSwitchViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet ISHomeViewController *homeViewController;
@property (nonatomic, retain) IBOutlet ISHelpViewController *helpViewController;
@property (nonatomic, retain) IBOutlet ISConfigViewController *configViewController;
@property (nonatomic, retain) IBOutlet ISMapViewController *mapViewController;
@property (nonatomic, retain) IBOutlet ISRecordsViewController *recordsViewController;

-(void) switchView:(NSInteger) viewTag;

@end
