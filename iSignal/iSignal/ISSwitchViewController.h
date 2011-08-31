//
//  ISSwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISLiteViewController.h"
#import "ISLiteHelpViewController.h"
#import "ISLiteConfigViewController.h"

#define TAG_SWITCHVIEW 0
#define TAG_LITE_VIEW 1
#define TAG_LITEHELP_VIEW 2
#define TAG_LITECONFIG_VIEW 3
#define TAG_LITEMAP_VIEW 4
#define TAG_LITERECORDS_VIEW 5
#define COUNT_SUB_VIEW_TAG 5

@interface ISSwitchViewController : UIViewController

@property (nonatomic, retain) IBOutlet ISLiteViewController *isLiteViewController;
@property (nonatomic, retain) IBOutlet ISLiteHelpViewController *isLiteHelpViewController;
@property (nonatomic, retain) IBOutlet ISLiteConfigViewController *isLiteConfigViewController;

-(void) switchView:(NSInteger) viewTag;

@end
