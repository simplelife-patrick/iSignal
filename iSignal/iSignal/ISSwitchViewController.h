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

#define TAG_SWITCHVIEW 0
#define TAG_HOMEVIEW 1
#define TAG_HELPVIEW 2
#define TAG_CONFIGVIEW 3
#define TAG_MAPVIEW 4
#define TAG_RECORDSVIEW 5
#define TAG_COUNT_VIEWS 5

@interface ISSwitchViewController : UIViewController

@property (nonatomic, retain) IBOutlet ISHomeViewController *homeViewController;
@property (nonatomic, retain) IBOutlet ISHelpViewController *helpViewController;
@property (nonatomic, retain) IBOutlet ISConfigViewController *configViewController;

-(void) switchView:(NSInteger) viewTag;

@end
