//
//  ISConfigViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBUIUtils.h"

#import "ISConfigSwitcherCell.h"

#import "iSignalAppDelegate.h"

// TODO: Config Table Properties should be put in xml file which can be parsed by a tool class.
#define CONFIG_TABLE_SECTION_COUNT 1
#define CONFIG_TABLE_SECTION_0_INDEX 0
#define CONFIG_TABLE_SECTION_0_NAME NSLocalizedString(@"STR_CONFIG", nil)

#define CONFIG_TABLE_SECTION_0_ITEM_COUNT 3
#define CONFIG_TABLE_SECTION_0_ITEM_0_INDEX 0
#define CONFIG_TABLE_SECTION_0_ITEM_0_NAME NSLocalizedString(@"STR_RING", nil)
#define CONFIG_TABLE_SECTION_0_ITEM_1_INDEX 1
#define CONFIG_TABLE_SECTION_0_ITEM_1_NAME NSLocalizedString(@"STR_VIBRATE", nil)
#define CONFIG_TABLE_SECTION_0_ITEM_2_INDEX 2
#define CONFIG_TABLE_SECTION_0_ITEM_2_NAME NSLocalizedString(@"STR_LOCATION", nil)

@interface ISConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end
