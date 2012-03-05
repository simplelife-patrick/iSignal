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
#define CONFIG_TABLE_SECTION_INDEX_CONFIG 0
#define CONFIG_TABLE_SECTION_NAME_CONFIG NSLocalizedString(@"STR_CONFIG", nil)

#define CONFIG_TABLE_SECTION_CONFIG_ITEM_COUNT 3
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_RING_INDEX 0
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_RING_NAME NSLocalizedString(@"STR_RING", nil)
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_VIBRATE_INDEX 1
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_VIBRATE_NAME NSLocalizedString(@"STR_VIBRATE", nil)
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_LOCATION_INDEX 2
#define CONFIG_TABLE_SECTION_CONFIG_ITEM_LOCATION_NAME NSLocalizedString(@"STR_LOCATION", nil)

#define CELL_IDENTIFIER_APPCONFIG @"CellIdentifier_AppConfig"

@interface ISConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end
